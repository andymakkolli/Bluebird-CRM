<?php

/*
 +--------------------------------------------------------------------+
 | CiviCRM version 4.4                                                |
 +--------------------------------------------------------------------+
 | Copyright CiviCRM LLC (c) 2004-2013                                |
 +--------------------------------------------------------------------+
 | This file is a part of CiviCRM.                                    |
 |                                                                    |
 | CiviCRM is free software; you can copy, modify, and distribute it  |
 | under the terms of the GNU Affero General Public License           |
 | Version 3, 19 November 2007 and the CiviCRM Licensing Exception.   |
 |                                                                    |
 | CiviCRM is distributed in the hope that it will be useful, but     |
 | WITHOUT ANY WARRANTY; without even the implied warranty of         |
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.               |
 | See the GNU Affero General Public License for more details.        |
 |                                                                    |
 | You should have received a copy of the GNU Affero General Public   |
 | License and the CiviCRM Licensing Exception along                  |
 | with this program; if not, contact CiviCRM LLC                     |
 | at info[AT]civicrm[DOT]org. If you have questions about the        |
 | GNU Affero General Public License or the licensing of CiviCRM,     |
 | see the CiviCRM license FAQ at http://civicrm.org/licensing        |
 +--------------------------------------------------------------------+
 */

/**
 * File for the CiviCRM APIv3 NYSS functions
 *
 * @package CiviCRM_APIv3
 * @subpackage API_NYSS
 * @copyright CiviCRM LLC (c) 2004-2013
 */

/*
 * Where most apis are object-oriented (they create/update/delete rows in a table),
 * this API is more like a BAO layer specific to NYSS interaction from the public website
 * (and other purposes).
 */

/**
 * Create or update a nyss
 *
 * @param array $params  Associative array of property
 *                       name/value pairs to insert in new 'nyss'
 * @example nyssCreate.php Std Create example
 *
 * @return array api result array
 * {@getfields nyss_create}
 * @access public
 */
function civicrm_api3_nyss_create($params) {
  return _civicrm_api3_basic_create(_civicrm_api3_get_BAO(__FUNCTION__), $params);
}

/**
 * Adjust Metadata for Create action
 *
 * The metadata is used for setting defaults, documentation & validation
 * @param array $params array or parameters determined by getfields
 */
function _civicrm_api3_nyss_create_spec(&$params) {
  $params['title']['api.required'] = 1;
}

/**
 * Returns array of nyss matching a set of one or more group properties
 *
 * @param array $params  (referance) Array of one or more valid
 *                       property_name=>value pairs. If $params is set
 *                       as null, all nyss will be returned
 *
 * @return array  (referance) Array of matching nyss
 * {@getfields nyss_get}
 * @access public
 */
function civicrm_api3_nyss_get($params) {
  return _civicrm_api3_basic_get(_civicrm_api3_get_BAO(__FUNCTION__), $params);
}

/**
 * delete an existing nyss
 *
 * This method is used to delete any existing nyss. id of the group
 * to be deleted is required field in $params array
 *
 * @param array $params  (reference) array containing id of the group
 *                       to be deleted
 *
 * @return array  (referance) returns flag true if successfull, error
 *                message otherwise
 * {@getfields nyss_delete}
 * @access public
 */
function civicrm_api3_nyss_delete($params) {
  return _civicrm_api3_basic_delete(_civicrm_api3_get_BAO(__FUNCTION__), $params);
}

