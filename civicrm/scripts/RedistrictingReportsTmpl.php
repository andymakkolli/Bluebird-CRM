<?php

// Project: BluebirdCRM
// Authors: Ash Islam
// Organization: New York State Senate
// Date: 2012-12-17

//-------------------------------------------------------------------------------------
// This file contains the markup to render the summary page for redistricting
// in HTML format. This is not intended to be standalone and is called by
// RedistrictingReports.php
//-------------------------------------------------------------------------------------

?>

<?php if ($format == 'text') {

	if ($mode == 'summary'){

		$label = "
${senator_name} District {$senate_district}\n\n
Summary of contacts that are outside district {$senate_district}\n\n
The number on the left is a count of the contacts that were in District {$senate_district}\n
and are now in district specified. The number on the right is the total count\n
of value added contacts that reside in that district which includes contacts\n
that were already there before redistricting.\n
";

		$columns = array(
			"Senate District" => 12,
			"Individuals" => 15,
			"Households" => 14,
			"Organization" => 14,
			"Total"	=> 16
		);

		$heading = $label . create_table_header($columns);

		$output_row = "";
		ksort($district_counts);

		foreach( $district_counts as $dist => $dist_cnts ){
			$output_row .=  fixed_width($dist, 12, false, "Unknown")
						   .fixed_width(get($dist_cnts['individual'], 'changed', '0') . " / " .get($dist_cnts['individual'], 'total', '0'), 15, true)
						   .fixed_width(get($dist_cnts['household'], 'changed', '0') . " / " . get($dist_cnts['household'], 'total', '0'), 14, true)
						   .fixed_width(get($dist_cnts['organization'], 'changed', '0') . " / " .get($dist_cnts['organization'], 'total', '0'), 14, true)
						   .fixed_width(get($dist_cnts['all'], 'changed', '0') . " / " . get($dist_cnts['all'], 'total', '0'), 16, true) ."\n";
		}

		print $heading . $output_row;
	}

	// ----------------------------------------------------------------------
	// Detail Report                                                    	|
	// ----------------------------------------------------------------------

	else if ($mode == 'detail'){
		$output = "";

		// Column names and widths
		$columns = array(
			"individual" => array(
				"Name" => 30, "Sex" => 6, "Age" => 6, "Address" => 25, "City" => 17, "Zip" => 6,
				"Email" => 20, "Source" => 9, "Cases" => 8, "Acts" => 10, "Groups" =>8, "BB Rec#" => 9 ),

			"organization" => array(
				"Organization Name" => 30, "Address" => 37, "City" => 17, "Zip" => 6, "Email" => 20,
		        "Source" => 9, "Cases" => 8, "Acts" => 10, "Groups" =>8, "BB Rec#" => 9 ),

			"household" => array(
				"Household Name" => 30, "Address" => 37, "City" => 17, "Zip" => 6, "Email" => 20,
		        "Source" => 9, "Cases" => 8, "Acts" => 10, "Groups" =>8, "BB Rec#" => 9)
		);

		// Sort by districts
		ksort($contacts_per_dist);

		// Ignore contacts in District 0. They are either out of state or
		// won't be assigned to another district regardless.
		unset($contacts_per_dist["0"]);

		foreach( $contacts_per_dist as $dist => $contact_types ){
			foreach( $contact_types as $type => $contact_array ){

				$label = "\nDistrict $dist : " . ucfirst($type) . "s\n";
				$heading = create_table_header($columns[$type]);
				$output .= $label . $heading;

				foreach($contact_array as $contact){
					if ($type == "individual"){
						$output .= fixed_width($contact['last_name'].", ".$contact['first_name'], 30)
						         . fixed_width(get_gender($contact['gender_id']),6, true)
						         . fixed_width(get_age($contact['birth_date']), 6, false)
						         . fixed_width($contact['street_address'], 25, false, "---") . " ";
					}
					else if ($type == "household"){
						$output .= fixed_width($contact['household_name'], 29) . " "
								.  fixed_width($contact['street_address'], 37, false, "---") . " ";
					}
					else if ($type == "organization"){
						$output .= fixed_width($contact['organization_name'], 29) . " "
								.  fixed_width($contact['street_address'], 37, false, "---") . " ";
					}

					$output .=  fixed_width($contact['city'], 15) . " "
						      . fixed_width($contact['postal_code'],6)
						      . fixed_width($contact['email'], 21, false, "---")
						      . fixed_width($contact['source'], 9, true )
						      . fixed_width($contact['case_count'], 9)
						      . fixed_width($contact['activity_count'], 9)
						      . fixed_width($contact['group_count'], 9)
						      . fixed_width($contact['contact_id']);
					$output .= "\n";
				}
			}
		}

		print $output . "\n\n";
	}
}
?>

<?php if ($format == 'html'): ?>
<html>
	<head>
		<title>
			<?= $title ?>
		</title>
		<style type="text/css">
			table {
				border-width: 1px;
				border-spacing: 2px;
				border-style: outset;
				border-color: gray;
				border-collapse: collapse;
				background-color: white;
			}
			table.summary {
				width:500px;
			}
			table.detail {
				width:1100px;
			}
			table th {
				border-width: 1px;
				padding: 5px;
				border-style: inset;
				border-color: gray;
				background-color: white;
				-moz-border-radius: ;
			}
			table td {
				border-width: 1px;
				padding: 5px;
				border-style: inset;
				border-color: #DDD;
				background-color: white;
				font-size:14px;
			}
			hr {
				border:1px solid #999;
				border-style: solid none none none;
			}
		</style>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
		<script src="http://code.highcharts.com/highcharts.js"></script>

	</head>
	<body>

		<?php if ($mode == "summary"): ?>
		<h1>Redistricting Summary for Senate District <?= $senate_district ?></h1>
		<h3><?= $senator_name ?></h3>
		<hr/>
		<p>The following table indicates the number of individuals, households, and organizations that will
		   be in the districts shown in the left column.
		</p>

		<p>
			The number on the left is a count of the contacts that were in District <?= $senate_district ?>
			and are now in district specified.<br/> The number on the right is the total count
			of value added contacts that reside in that district which<br/> includes contacts
			that were already there before redistricting.
		</p>

		<table class='summary'>
			<tr>
				<th>District</th>
				<th>Individuals</th>
				<th>Households</th>
				<th>Organizations</th>
				<th>Totals</th>
			</tr>

			<?php

			unset($district_counts["0"]);
			ksort($district_counts);

			foreach( $district_counts as $dist => $dist_cnts ): ?>
				<tr>
					<td><?= $dist ?></td>
					<td><?= get($dist_cnts['individual'], 'changed', '0') . " / " .get($dist_cnts['individual'], 'total', '0') ?></td>
					<td><?= get($dist_cnts['household'], 'changed', '0') . " / " . get($dist_cnts['household'], 'total', '0') ?></td>
					<td><?= get($dist_cnts['organization'], 'changed', '0') . " / " .get($dist_cnts['organization'], 'total', '0') ?></td>
					<td><?= get($dist_cnts['all'], 'changed', '0') . " / " .get($dist_cnts['all'], 'total', '0') ?></td>
				</tr>
			<?php endforeach; ?>
		</table>

	<?php elseif ($mode == "detail"): ?>
		<h1>Redistricting Details for Senate District <?= $senate_district ?></h1>
		<h3><?= $senator_name ?></h3>
		<hr/>

		<p>The tables below list the contacts that will be in the districts specified.
		</p>
		<?php

		// Table columns for contact details
		$html_columns = array(
			"individual" => array(
				"Name" => 30, "Sex" => 6, "Age" => 6, "Address" => 25, "City" => 17, "Zip" => 6,
				"Email" => 20, "Source" => 9, "Cases" => 8, "Acts" => 10, "Groups" => "", "BB Rec#" => 9 ),

			"organization" => array(
				"Organization Name" => 30, "Address" => 37, "City" => 17, "Zip" => 6, "Email" => 20,
		        "Source" => 9, "Cases" => 8, "Acts" => 10, "Groups" => "", "BB Rec#" => 9 ),

			"household" => array(
				"Household Name" => 30, "Address" => 37, "City" => 17, "Zip" => 6, "Email" => 20,
		        "Source" => 9, "Cases" => 8, "Acts" => 10, "Groups" => "", "BB Rec#" => 9)
		);

		// Ignore district 0 for now
		// Sort the detailed data by district number
		unset($contacts_per_dist['0']);
		ksort($contacts_per_dist);

		foreach( $contacts_per_dist as $dist => $contact_types )
			foreach( $contact_types as $type => $contact_array ): ?>

				<h3>District <?= "$dist : " . ucfirst($type) . "s (" . count($contact_array) . ")"  ?></h3>
				<table id="dist_<?= $dist . "_" . $type ?>" class='detail'>
					<tr>
					<?php foreach($html_columns[$type] as $name => $width): ?>
						<th><?= $name ?></th>
					<?php endforeach; ?>
					</tr>

					<?php foreach($contact_array as $contact): ?>
				 	<tr>
				 		<?php if($type == "individual"): ?>
				 			<td><?= $contact['last_name'].", ".$contact['first_name']?></td>
				 			<td><?= get_gender($contact['gender_id']) ?></td>
				 			<td><?= get_age($contact['birth_date']) ?></td>
				 			<td><?= $contact['street_address'] ?></td>

				 	    <?php elseif($type == "household"): ?>
				 			<td><?= $contact['household_name'] ?></td>
				 			<td><?= $contact['street_address'] ?></td>

				 		<?php elseif($type == "organization"): ?>
				 			<td><?= $contact['organization_name'] ?></td>
				 			<td><?= $contact['street_address'] ?></td>

						<?php endif; ?>
							<td><?= $contact['city'] ?></td>
							<td><?= $contact['postal_code'] ?></td>
					      	<td><?= $contact['email'] ?></td>
					      	<td><?= $contact['source'] ?></td>
					      	<td><?= $contact['case_count'] ?></td>
					      	<td><?= $contact['activity_count'] ?></td>
					      	<td><?= $contact['group_count'] ?></td>
					      	<td><?= $contact['contact_id'] ?></td>
					</tr>
					<?php endforeach; ?>

				</table>
				<br/>
				<br/>
			<?php endforeach; ?>
	<?php endif; ?>
	</body>
	<script>
		$(document).ready(function(){

		});
	</script>
</html>
<?php endif; ?>