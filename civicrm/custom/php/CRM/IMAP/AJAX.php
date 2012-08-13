<?php
require_once 'CRM/Core/Error.php';
require_once 'CRM/Utils/IMAP.php';
require_once 'CRM/Core/DAO.php';

class CRM_IMAP_AJAX {
    private static $db = null;

    // private static $server = "{webmail.senate.state.ny.us/imap/notls}";
    // private static $user = 'crmdev';
    // private static $pass = 'p9x64';
    private static $server = '{imap.gmail.com:993/imap/ssl/novalidate-cert/norsh}Inbox';
    private static $imap_accounts = array();
    private static $bbconfig = null;

    private static function setupImap() {
        require_once dirname(__FILE__).'/../../../../../civicrm/scripts/bluebird_config.php';
        self::$bbconfig = get_bluebird_instance_config();

        $imapAccounts = explode(',', self::$bbconfig['imap.accounts']);
        foreach($imapAccounts as $imapAccount) {
            list($user, $pass) = explode('|', $imapAccount);
            self::$imap_accounts[] = array( 'user'  =>  $user,
                                            'pass'  =>  $pass);
        }

    }

    private static function db() {
        // Load the configuration for this instance
 
        if (self::$db == null) {
            $nyss_conn = new CRM_Core_DAO();
            $nyss_conn = $nyss_conn->getDatabaseConnection();
            self::$db = $nyss_conn->connection;
        }
        return self::$db;
    }

    private static function get($key) {
        return mysql_real_escape_string($_GET[$key], self::db());
    }

    public static function getUnmatchedMessages() {
        self::setupImap();
        //Fetch the IMAP Headers
        $conn = imap_open(self::$server, self::$imap_accounts[0]['user'], self::$imap_accounts[0]['pass']);
        $ids = imap_search($conn,"SINCE \"24 Jul 2012\" BEFORE \"31 Jul 2012\"",SE_UID);
        $headers = imap_fetch_overview($conn,implode(',',$ids),FT_UID);
        $messages = array();
        foreach($headers as $header) {
            if( in_array($header->uid,$ids)) {

                //Clean up the date to Mon DD, YYYY format
                $date_parts = explode(' ',$header->date);
                $header->date_fmt = "{$date_parts[2]} {$date_parts[1]}, {$date_parts[3]}";

                //Parse out the name and email portions of the from header argument
                //Generally these fall into one of the two forms
                //    crmdev@nysenate.gov
                //    CRM Dev <crmdev@nysenate.gov>
                $from_parts = explode(' ',$header->from);
                if(count($from_parts)==1) {
                    $header->from_email = $header->from;
                    $header->from_name = '';
                } else {
                    $header->from_email = str_replace(array('<','>'),'',array_pop($from_parts));
                    $header->from_name = implode(' ',$from_parts);
                }

                $messages[$header->uid] = $header;
            }
        }
        echo json_encode($messages);
        CRM_Utils_System::civiExit();
    }

    public static function getMessageDetails() {
        self::setupImap();
        $id = self::get('id');
        $imap_id = self::get('imap_id');
        $imap = new CRM_Utils_IMAP(self::$server,
                                    self::$imap_accounts[$imap_id]['user'],
                                    self::$imap_accounts[$imap_id]['pass']);
        $email = $imap->getmsg_uid($id);
        echo ($email->plainmsg) ? str_replace("\n",'<br>',$email->plainmsg) : $email->htmlmsg;
        CRM_Utils_System::civiExit();
    }

    public static function getContacts() {
        $start = microtime(true);
        $s = self::get('s');
        $phone = self::get('phone');
        $city = self::get('city');
        $state_id = self::get('state');
        $first_name = self::get('first_name');
        $last_name = self::get('last_name');
        $street_address = self::get('street_address');
        $query = <<<EOQ
SELECT DISTINCT *
FROM civicrm_contact AS contact
  JOIN civicrm_address AS address ON contact.id=address.contact_id
  JOIN civicrm_state_province AS state ON address.state_province_id=state.id
  JOIN civicrm_phone as phone ON phone.contact_id=contact.id
WHERE contact.is_deleted=0
  AND state.id='$state_id'
  AND address.city LIKE '%$city%'
  AND contact.first_name LIKE '%$first_name%'
  AND contact.last_name LIKE '%$last_name%'
  AND address.street_address LIKE '%$street_address%'
  AND phone.phone LIKE '%$phone%'
ORDER BY contact.sort_name
EOQ;
        $result = mysql_query($query, self::db());
        $results = array();
        while($row = mysql_fetch_assoc($result)) {
            $results[] = $row;
        }
        echo json_encode(array_values($results));
        $end = microtime(true);
        if(self::get('debug')) echo $end-$start;
        mysql_close(self::$db);
        CRM_Utils_System::civiExit();
    }

    public static function assignMessage() {
        //take UID in messageUid, read message from IMAP
        //assign to contactId in Bluebird
        //move message to deleted/archived folder
        self::setupImap();
        $messageUid = self::get('messageId');
        $contactId = self::get('contactId');
        $imap = new CRM_Utils_IMAP(self::$server, self::$imap_accounts[0]['user'], self::$imap_accounts[0]['pass']);
        $email = $imap->getmsg_uid($messageUid);
        $senderName = $email->sender[0]->personal;
        $senderEmailAddress = $email->sender[0]->mailbox . '@' . $email->sender[0]->host;
        $date = $email->date;
        $subject = $email->subject;
        $body = ($email->plainmsg) ? str_replace("\n",'<br>',$email->plainmsg) : $email->htmlmsg;
        
        require_once 'api/api.php';
        $params = array(
            'activity_type_id' => 12,
            'source_contact_id' => 1,
            'assignee_contact_id' => 1,
            'target_contact_id' => $contactId,
            'subject' => $subject,
            'status_id' => 2,
            'activity_date_time' => $date,
            'details' => $body,
            'version' => 3
        );
        $activity = civicrm_api('activity', 'create', $params);
        $imap->movemsg_uid($messageUid, 'Archive');
        CRM_Utils_System::civiExit();
    }

    public static function assignTag() {
        $activityIds    =   self::get('activityIds');
        $contactIds     =   self::get('contactIds');
        $tagIds         =   self::get('tagIds');
        $activityIds    =   split(',', $activityIds);
        $contactIds     =   split(',', $contactIds);
        $tagIds         =   split(',', $tagIds);

        // If there are no tagIds or it's zero, return an error message
        // via JSON so we can display it to the user.
        if(is_null($tagIds) || $tagIds == 0) {
            $returnCode = array('code'      =>  'ERROR',
                                'message'   =>  'No valid tags.');
            echo json_encode($returnCode);
            CRM_Utils_System::civiExit();
        }

        require_once 'api/api.php';
        foreach($contactIds as $contactId) {
            $params = array( 
                            'entity_table'  =>  'civicrm_contact',
                            'entity_id'     =>  $contactId,
                            'tag_id'        =>  $tagIds,
                            'version'       =>  3,
                            );

            $result = civicrm_api('entity_tag', 'create', $params );
            if($result['is_error']) {
                $returnCode = array('code'      =>  'ERROR',
                                    'message'   =>  "Problem with Contact ID: {$contactId}");
                echo json_encode($returnCode);
                CRM_Utils_System::civiExit();
            }
        }

        foreach($activityIds as $activityId) {
            $params = array( 
                            'entity_table'  =>  'civicrm_activity',
                            'entity_id'     =>  $activityId,
                            'tag_id'        =>  $tagIds,
                            'version'       =>  3,
                            );

            $result = civicrm_api('entity_tag', 'create', $params );
            if($result['is_error']) {
                $returnCode = array('code'      =>  'ERROR',
                                    'message'   =>  "Problem with Activity ID: {$activityId}");
                echo json_encode($returnCode);
                CRM_Utils_System::civiExit();
            }
        }

        $returnCode = array('code'    =>  'SUCCESS');
        echo json_encode($returnCode);
        CRM_Utils_System::civiExit();
    }

    public function getMatchedMessages() {
        require_once 'api/api.php';
        $params = array('version'   =>  3,
                        'tag_id'    =>  getInboxPollingTagId(),
                        );
        $result = civicrm_api('entity_tag', 'get', $params);

        $activities = array();
        foreach($result as $id) {
            $params = array('version'   =>  3,
                            'activity'  =>  'get',
                            );
            $activity = civicrm_api('activity', 'get', $params);

            $params = array('version'   =>  3,
                            'id'        =>  $activity['contact_id'],
                            );

            $contact = civicrm_api('contact', 'get', $params);

            $activities[$result['id']]['activity'] = $activity;
            $activities[$result['id']]['contact'] = $contact;
        }
        echo json_encode($activities);
        CRM_Utils_System::civiExit();
    }

    function getInboxPollingTagId() {
      require_once 'api/api.php';

      // Check if the tag exists
      $params = array(
        'name' => 'Inbox Polling Unprocessed',
        'version' => 3,
      );
      $result = civicrm_api('tag', 'get', $params);

      if($result && isset($result['id'])) {
        return $result['id'];
      }

      // If there's no tag, create it.
      $params = array( 
      'name' => 'Inbox Polling Unprocessed',
      'description' => 'Tag noting that this activity has been created by Inbox Polling and is still Unprocessed.',
      'version' => 3,
      );
      $result = civicrm_api('tag', 'create', $params);
      if($result && isset($result['id'])) {
        return $result['id'];
      }

}