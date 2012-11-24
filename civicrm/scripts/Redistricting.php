<?php

// Project: BluebirdCRM
// Authors: Stefan Crain, Graylin Kim, Ken Zalewski
// Organization: New York State Senate
// Date: 2012-10-26
// Revised: 2012-11-21

// ./Redistricting.php -S skelos --chunk 2000 --log 5 --max 10000
error_reporting(E_ERROR | E_PARSE | E_WARNING);
set_time_limit(0);

define('DEFAULT_CHUNK_SIZE', 1000);
define('DEFAULT_LOG_LEVEL', 'TRACE');

// Parse the options
require_once 'script_utils.php';
$prog = basename(__FILE__);
$shortopts = "c:l:m:n";
$longopts = array("chunk=", "log=", "max=", "dryrun");
$optlist = civicrm_script_init($shortopts, $longopts);

if ($optlist === null) {
    $stdusage = civicrm_script_usage();
    $usage = "[--chunk \"number\"] [--log \"5|4|3|2|1\"] [--max \"number\"] [--dryrun]";
    error_log("Usage: $prog  $stdusage  $usage\n");
    exit(1);
}

// Use instance settings to configure for SAGE
$bbcfg = get_bluebird_instance_config($optlist['site']);
$sage_base = array_key_exists('sage.api.base', $bbcfg) ? $bbcfg['sage.api.base'] : false;
$sage_key = array_key_exists('sage.api.key', $bbcfg) ? $bbcfg['sage.api.key'] : false;

if (!($sage_base && $sage_key)) {
    error_log(bbscript_log("fatal", "sage.api.base and sage.api.key must be set in your bluebird.cfg file."));
    exit(1);
}

$bulk_distassign_url = $sage_base.'/json/bulkdistrict/body?key='.$sage_key;

// Initialize script parameters from options and defaults
$chunk_size = $optlist['chunk'] ? $optlist['chunk'] : DEFAULT_CHUNK_SIZE;
$log_level = $optlist['log'] ? $optlist['log'] : DEFAULT_LOG_LEVEL;
$BB_LOG_LEVEL = $LOG_LEVELS[strtoupper($log_level)][0];
$dry_run = $optlist['dryrun'];
$max_id = $optlist['max'];

if ($max_id && is_numeric($max_id)) {
    $max_id_condition = ' AND address.id < '.$max_id;
}
else {
    $max_id_condition = '';
}

bbscript_log("debug", "Starting with $prog with chunk size of $chunk_size");

// Initialize CiviCRM
require_once 'CRM/Core/Config.php';
$config =& CRM_Core_Config::singleton();
$session =& CRM_Core_Session::singleton();

// Establish a connection to the instance database
$dao = new CRM_Core_DAO();
$db = $dao->getDatabaseConnection()->connection;

// Collect NY state addresses with a street address; any
// address not matching this criteria will not be included.
$query = "
    SELECT address.id,
           address.contact_id,
           address.street_name AS street1,
           address.street_type AS street2,
           address.city AS town,
           'NY' AS state,
           address.postal_code AS zip,
           address.street_number_suffix AS building_chr,
           address.street_number AS building,
           district.county_50 AS county_code,
           district.county_legislative_district_51,
           district.congressional_district_46 AS congressional_code,
           district.ny_senate_district_47 AS senate_code,
           district.ny_assembly_district_48 AS assembly_code,
           district.election_district_49 AS election_code,
           district.town_52,
           district.ward_53,
           district.school_district_54,
           district.new_york_city_council_55,
           district.neighborhood_56,
           district.last_import_57
    FROM civicrm_address as address
    JOIN civicrm_state_province as state_province
    JOIN civicrm_value_district_information_7 as district
    WHERE address.state_province_id=state_province.id
      AND district.entity_id = address.id
      AND state_province.abbreviation='NY'
      AND IFNULL(address.street_name,'') != ''
      $max_id_condition
    ORDER BY address.id ASC
";

bbscript_log("debug", "Querying the database for addresses using\n$query");
$result = mysql_query($query, $db);
$total_found = mysql_num_rows($result);

bbscript_log("debug", $total_found." addresses found.");
// start timer
$time_start = microtime(true);

// Store count statistics
$count = array(
    "total" => 0,
    "multimatch" => 0,
    "match" => 0,
    "nomatch" => 0,
    "invalid" => 0,
    "error" => 0,
    "exactmatch" => 0,
    "consolidatedRangeFill" => 0,
    "consolidatedMultimatch" => 0,
    "rangeFillFailure" => 0,
    "notfound" => 0,
    "totalCurlTime" => 0,
    "totalMysqlTime" => 0
);

$row_data = array();
$JSON_Payload = array();
$address_count = mysql_num_rows($result);

for ($rownum = 1; $rownum <= $address_count; $rownum++) {
    // Fetch the new row, no null check needed since we have the count
    // If we do pull back a NULL something bad happened and dying is okay
    $row = mysql_fetch_assoc($result);
    $row_data[$row['id']] = $row;

    // Clean the data manually till we can do mass validation.
    $town = clean($row['town']);
    $row['town'] = preg_replace(array('/^EAST /','/^WEST /','/^SOUTH /','/^NORTH /', '/ SPRINGS$/','/PETERSBURG$/'),array('E ','W ','S ','N ',' SPGS','PETERSBURGH'),$town);

    $match = array('/ AVENUE( EXT)?$/','/ STREET( EXT)?$/','/ PLACE/','/ EAST$/','/ WEST$/','/ SOUTH$/','/ NORTH$/','/^EAST (?!ST|AVE|RD|DR)/','/^WEST (?!ST|AVE|RD|DR)/','/^SOUTH (?!ST|AVE|RD|DR)/','/^NORTH (?!ST|AVE|RD|DR)/');
    $replace = array(' AVE$1',' ST$1',' PL',' E',' W',' S',' N','E ','W ','S ','N ');

    $street = clean($row['street2']);
    $row['street2'] = preg_replace($match, $replace, $street);

    $street = clean($row['street1']);
    $row['street1'] = preg_replace($match, $replace, $street);

    // Format for the bulkdistrict tool
    $JSON_Payload[$row['id']]= array(
        'street' => $row['street1'].' '.$row['street2'],
        'town' => $row['town'],
        'state' => $row['state'],
        'zip5' => $row['zip'],
        'apt' => NULL,
        'building_chr' => $row['building_chr'],
        'building' => $row['building'] ,
    );

    // keep accumulating until we reach chunk size or the end of our addresses.
    if (count($JSON_Payload) < $chunk_size && $rownum != $address_count) {
        continue;
    }

    // Encode our payload and reset for the next batch
    $JSON_Payload_encoded = json_encode($JSON_Payload);
    $JSON_Payload = array();

    // Send the cURL request
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $bulk_distassign_url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $JSON_Payload_encoded);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array("Content-Type: application/json", "Content-length: ".strlen($JSON_Payload_encoded)));
    $output = curl_exec($ch);
    $curl_time = curl_getinfo($ch, CURLINFO_TOTAL_TIME);
    curl_close($ch);
    bbscript_log("trace", "Received Curl in     ".round($curl_time, 3));
    $count['totalCurlTime'] += $curl_time;

    // check for malformed response
    if (( $output === null )) {
        bbscript_log("fatal", "CURL Failed to receive a Response");
        continue;
    }

    // Parse the response and check for errors
    $response = @json_decode($output, true);

    if (($response === null && json_last_error() !== JSON_ERROR_NONE )) {
        bbscript_log("fatal", "Malformed JSON");
        continue;
    }

    // Process the results
    $count['total'] += count($response);
    $Update_Payload = array();

    foreach ($response as $id => $value) {
        $status_code = $value['status_code'];
        $message = $value['message'];

        if ($status_code == "MATCH") {
            $count['match']++;
            bbscript_log("trace", "[MATCH][".$value['message']."] on record #".$value['address_id']);
            if ($message == "EXACT MATCH") {
                $count['exactmatch']++;
            }
            elseif ($message == "CONSOLIDATED RANGEFILL") {
                $count['consolidatedRangeFill']++;
            }
            elseif ($message == "CONSOLIDATED MULTIMATCH") {
                $count['consolidatedMultimatch']++;
            }

            $Update_Payload[$value['address_id']] = array(
                'assembly_code'=>$value['assemblyCode'],
                'congressional_code'=>$value['congressionalCode'],
                'election_code'=>$value['electionCode'],
                'senate_code'=>$value['senateCode'],
                'county_code'=>$value['countyCode'],
                // 'fire_code'=>$value['matches'][0]['fire_code'],
                // 'ward_code'=>$value['matches'][0]['ward_code'],
                // 'vill_code'=>$value['matches'][0]['vill_code'],
                // 'town_code'=>$value['matches'][0]['town_code'],
                // 'cleg_code'=>$value['matches'][0]['cleg_code'],
                // 'school_code'=>$value['matches'][0]['school_code'],
            );

        }
        elseif ($status_code == "MULTIMATCH") { // shouldn't exist anymore
            $count['multimatch']++;
            bbscript_log("warn", "[MULTIMATCH][".$value['message']."] on record #".$value['address_id']);

        }
        elseif ($status_code == "NOMATCH") {
            if ($message == "RANGEFILL") {
                $count['rangeFillFailure']++;
            }
            else {
                $count['notfound']++;
            }

            $count['nomatch']++;
            bbscript_log("warn", "[NOMATCH][".$value['message']."] on record #".$value['address_id']);

        }
        elseif ($status_code == "INVALID") {
             $count['invalid']++;
             bbscript_log("warn", "[INVALID][".$value['message']."] on record #".$value['address_id']);
        }
        else { // Unknown status_code, what?!?
            $count['error']++;
            bbscript_log("ERROR", "on record ".$value['address_id']." with message " .$value['message'] );
        }
    }

    // Store them into the database
    if (count($Update_Payload) > 0 && !$dry_run) {
        $update_time_start = microtime(true);
        bbscript_log("trace", "Updating ".count($Update_Payload)." records.");

        mysql_query("BEGIN", $db);
        foreach ($Update_Payload as $id => $value) {
            // bbscript_log("trace", "ID:$id - SD:{$value['senate_code']}, CO:{$value['county_code']}, CD:{$value['congressional_code']}, AD:{$value['assembly_code']}, ED:{$value['election_code']}");

            $row = $row_data[$id];

            $note = "ADDRESS ID: $id\nADDRESS: ".$row['building'].' '.$row['building_chr'].' '.$row['street1'].' '.$row['street2'].', '.$row['town'].', '.$row['state'].', '.$row['zip']."\nUPDATES: SD:".getValue($row['senate_code'])."=>{$value['senate_code']}, CO:".getValue($row['county_code'])."=>{$value['county_code']}, CD:".getValue($row['congressional_code'])."=>{$value['congressional_code']}, AD:".getValue($row['assembly_code'])."=>{$value['assembly_code']}, ED:".getValue($row['election_code'])."=>{$value['election_code']}";

            mysql_query("
                INSERT INTO civicrm_note (entity_table, entity_id, note, contact_id, modified_date, subject, privacy)
                VALUES ('civicrm_contact', {$row['contact_id']}, '$note', 1, '".date("Y-m-d")."', 'SAVED DISTRICT INFO', 0)", $db
            );

            mysql_query("
                UPDATE civicrm_value_district_information_7
                SET congressional_district_46 = {$value['congressional_code']},
                    ny_senate_district_47 = {$value['senate_code']},
                    ny_assembly_district_48 = {$value['assembly_code']},
                    election_district_49 = {$value['election_code']},
                    county_50 = {$value['county_code']}
                WHERE civicrm_value_district_information_7.entity_id = $id", $db
            );
            // ",
            // county_legislative_district_51   = {$value['cleg_code']},
            // town_52   = {$value['town_code']},
            // ward_53   = {$value['ward_code']},
            // school_district_54   = {$value['school_code']},
        }
        mysql_query("COMMIT", $db);

        $update_time = get_elapsed_time($update_time_start);
        bbscript_log("trace", "Updated database in ".round($update_time, 3));
        $count['totalMysqlTime'] += $update_time;
    }
    else {
        bbscript_log("warn", "No Records to update");
    }

    $row_data = array();

    // timer for debug
    $time = get_elapsed_time($time_start);
    $Records_per_sec = round($count['total'] / $time, 1);
    $Mysql_per_sec = ($count['totalMysqlTime'] == 0 ) ? 0 : round($count['total'] / $count['totalMysqlTime'], 1);
    $Curl_per_sec = round($count['total'] / $count['totalCurlTime'], 1);
    $Multimatch_percent = round($count['multimatch'] / $count['total'] * 100, 2);
    $Match_percent = round((($count['match'] / $count['total']) * 100), 2);
    $Nomatch_percent = round($count['nomatch'] / $count['total'] * 100, 2);
    $Invalid_percent = round($count['invalid'] / $count['total'] * 100, 2);
    $Error_percent = round($count['error'] / $count['total'] * 100,  2);
    $ExactMatch_percent = round($count['exactmatch'] / $count['total'] * 100, 2);
    $ConsolidatedRangefill_percent = round($count['consolidatedRangeFill'] / $count['total'] * 100, 2);
    $ConsolidatedMultimatch_percent = round($count['consolidatedMultimatch'] / $count['total'] * 100, 2);
    $RangefillFailure_percent = round($count['rangeFillFailure'] / $count['total'] * 100, 2);
    $NotFound_percent = round($count['notfound'] / $count['total'] * 100, 2);

    $seconds_left = round(($total_found - $count['total']) / $Records_per_sec, 0);
    $finish_at = date('Y-m-d H:i:s', (time() + $seconds_left));

    bbscript_log("info", "-------    ------- ---- ---- ---- ---- ");
    bbscript_log("info", "[DONE @]           $finish_at (in ".$seconds_left." seconds)");
    bbscript_log("info", "[COUNT]            {$count['total']}");
    bbscript_log("info", "[TIME]             ".round($time, 4));

    bbscript_log("info", "[SPEED]    [TOTAL] $Records_per_sec per second (".$count['total']." in ".round($time, 3).")");
    bbscript_log("trace","[SPEED]    [MYSQL] $Mysql_per_sec per second (".$count['total']." in ".round($count['totalMysqlTime'], 3).")");
    bbscript_log("trace","[SPEED]    [CURL]  $Curl_per_sec per second (".$count['total']." in ".round($count['totalCurlTime'], 3).")");
    bbscript_log("info", "[MATCH]    [TOTAL] {$count['match']} ($Match_percent %)");
    bbscript_log("trace","[MATCH]    [EXACT] {$count['exactmatch']} ($ExactMatch_percent %)");
    bbscript_log("trace","[MATCH]    [RANGE] {$count['consolidatedRangeFill']} ($ConsolidatedRangefill_percent %)");
    bbscript_log("trace","[MATCH]    [MULTI] {$count['consolidatedMultimatch']} ($ConsolidatedMultimatch_percent %)");
    bbscript_log("info", "[NOMATCH]  [TOTAL] {$count['nomatch']} ($Nomatch_percent %)");
    bbscript_log("trace","[NOMATCH]  [RANGE] {$count['rangeFillFailure']} ($RangefillFailure_percent %)");
    bbscript_log("info", "[MULTI]    [TOTAL] {$count['multimatch']} ($Multimatch_percent %)");
    bbscript_log("info", "[INVALID]  [TOTAL] {$count['invalid']} ($Invalid_percent %)");
    bbscript_log("info", "[ERROR]    [TOTAL] {$count['error']} ($Error_percent %)");
}

bbscript_log("info", "Completed redistricting addresses");

function clean($string)
{
    return preg_replace("/[.,']/","",strtoupper(trim($string)));
}

function getValue($string)
{
    if ($string == FAlSE) {
         return "null";
    }
    else {
        return $string;
    }
}
