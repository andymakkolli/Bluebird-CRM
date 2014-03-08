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
 *
 * @package CRM
 * @copyright CiviCRM LLC (c) 2004-2013
 * $Id$
 *
 */

require_once 'api/api.php'; //NYSS

class CRM_Report_Form_Contact_LoggingSummary extends CRM_Logging_ReportSummary {
  function __construct() {
    parent::__construct();

    $logTypes = array();
    foreach ( array_keys($this->_logTables) as  $table ) {
      $type = $this->getLogType($table);
      $logTypes[$type] = $type;
    }
    asort($logTypes);

    $this->_columns = array(
      'log_civicrm_entity' => array(
        'dao' => 'CRM_Contact_DAO_Contact',
        'alias' => 'entity_log',
        'fields' => array(
          'id' => array(
            'no_display' => TRUE,
            'required' => TRUE,
          ),
          'log_action' => array(
            'default' => TRUE,
            'title' => ts('Action'),
          ),
          'log_type' => array(
            'required' => TRUE,
            'title' => ts('Log Type'),
          ),
          'log_user_id' => array(
            'no_display' => TRUE,
            'required' => TRUE,
          ),
          'log_date' => array(
            'default' => TRUE,
            'required' => TRUE,
            'type' => CRM_Utils_Type::T_TIME,
            'title' => ts('When'),
          ),
          'altered_contact' => array(
            'default' => TRUE,
            'name' => 'display_name',
            'title' => ts('Altered Contact'),
            'alias' => 'modified_contact_civireport',
          ),
          //NYSS 3461
          'altered_contact_sort_name' => array(
            'required' => TRUE,
            'name' => 'sort_name',
            'no_display' => TRUE,
            'alias' => 'modified_contact_civireport',
          ),
          'altered_contact_id' => array(
            'name' => 'id',
            'no_display' => TRUE,
            'required' => TRUE,
            'alias'    => 'modified_contact_civireport',
          ),
          'log_conn_id' => array(
            'no_display' => TRUE,
            'required' => TRUE,
          ),
          //NYSS add job ID
          'log_job_id' => array(
            'title'   => ts('Job ID'),
          ),
          //NYSS show details
          'log_details' => array(
            'title'   => ts('Show Details'),
            'name'    => 'id',
          ),
          'is_deleted' => array(
            'no_display' => TRUE,
            'required' => TRUE,
            'alias' => 'modified_contact_civireport',
          ),
        ),
        'filters' => array(
          'log_date' => array(
            'title' => ts('When'),
            'operatorType' => CRM_Report_Form::OP_DATE,
            'type' => CRM_Utils_Type::T_DATE,
          ),
          'altered_contact' => array(
            'name' => 'display_name',
            'title' => ts('Altered Contact'),
            'type' => CRM_Utils_Type::T_STRING,
            'alias' => 'modified_contact_civireport',
          ),
          'altered_contact_id' => array(
            'name' => 'id',
            'type' => CRM_Utils_Type::T_INT,
            'alias' => 'modified_contact_civireport',
            'no_display' => TRUE,
          ),
          'log_type' => array(
            'operatorType' => CRM_Report_Form::OP_MULTISELECT,
            'options' => $logTypes,
            'title' => ts('Log Type'),
            'type' => CRM_Utils_Type::T_STRING,
          ),
          'log_type_table' => array(
            'name'  => 'log_type',
            'title' => ts('Log Type Table'),
            'type' => CRM_Utils_Type::T_STRING,
          ),
          'log_action' => array(
            'operatorType' => CRM_Report_Form::OP_MULTISELECT,
            'options' => array('Insert' => ts('Insert'), 'Update' => ts('Update'), 'Delete' => ts('Delete')),
            'title' => ts('Action'),
            'type' => CRM_Utils_Type::T_STRING,
          ),
          //NYSS add job ID
          'log_job_id' => array(
            'title' => ts('Job ID'),
            'type' => CRM_Utils_Type::T_STRING,
          ),
          'id' => array(
            'no_display' => TRUE,
            'type' => CRM_Utils_Type::T_INT,
          ),
        ),
        //NYSS 3461
        'order_bys'  =>
        array(
          'altered_contact_sort_name' =>
          array(
            'title' => ts('Altered Contact'),
            'name' => 'sort_name',
            'alias' => 'modified_contact_civireport',
          ),
          'log_date' =>
          array(
            'title' => ts('Log Date'),
          ),
        ),
      ),
      'altered_by_contact' => array(
        'dao' => 'CRM_Contact_DAO_Contact',
        'alias' => 'altered_by_contact',
        'fields' => array(
          'display_name' => array(
            'default' => TRUE,
            'name' => 'display_name',
            'title' => ts('Altered By'),
          ),
        ),
        'filters' => array(
          'display_name' => array(
            'name' => 'display_name',
            'title' => ts('Altered By'),
            'type' => CRM_Utils_Type::T_STRING,
          ),
        ),
      ),
    );
  }

  function alterDisplay(&$rows) {
    //CRM_Core_Error::debug_var('rows', $rows);
    // cache for id → is_deleted mapping
    $isDeleted = array();
    $newRows = array();

    foreach ($rows as $key => &$row) {
      if (!isset($isDeleted[$row['log_civicrm_entity_altered_contact_id']])) {
        $isDeleted[$row['log_civicrm_entity_altered_contact_id']] =
          CRM_Core_DAO::getFieldValue('CRM_Contact_DAO_Contact', $row['log_civicrm_entity_altered_contact_id'], 'is_deleted') !== '0';
      }

      if (CRM_Utils_Array::value('log_civicrm_entity_altered_contact', $row) &&
        !$isDeleted[$row['log_civicrm_entity_altered_contact_id']]) {
        $row['log_civicrm_entity_altered_contact_link'] =
          CRM_Utils_System::url('civicrm/contact/view', 'reset=1&cid=' . $row['log_civicrm_entity_altered_contact_id']);
        $row['log_civicrm_entity_altered_contact_hover'] = ts("Go to contact summary");
        $entity = $this->getEntityValue($row['log_civicrm_entity_id'], $row['log_civicrm_entity_log_type'], $row['log_civicrm_entity_log_date']);
        if ($entity)
          $row['log_civicrm_entity_altered_contact'] = $row['log_civicrm_entity_altered_contact'] . " [{$entity}]";
      }
      $row['altered_by_contact_display_name_link'] = CRM_Utils_System::url('civicrm/contact/view', 'reset=1&cid=' . $row['log_civicrm_entity_log_user_id']);
      $row['altered_by_contact_display_name_hover'] = ts("Go to contact summary");

      if ($row['log_civicrm_entity_is_deleted'] and 'Update' == CRM_Utils_Array::value('log_civicrm_entity_log_action', $row)) {
        $row['log_civicrm_entity_log_action'] = ts('Delete (to trash)');
      }

      if ('Contact' == CRM_Utils_Array::value('log_type', $this->_logTables[$row['log_civicrm_entity_log_type']]) &&
          CRM_Utils_Array::value('log_civicrm_entity_log_action', $row) == 'Insert' ) {
        $row['log_civicrm_entity_log_action'] = ts('Update');
      }

      if ($newAction = $this->getEntityAction($row['log_civicrm_entity_id'],
                       $row['log_civicrm_entity_log_conn_id'],
                       $row['log_civicrm_entity_log_type'],
                       CRM_Utils_Array::value('log_civicrm_entity_log_action', $row)))
        $row['log_civicrm_entity_log_action'] = $newAction;

      $row['log_civicrm_entity_log_type'] = $this->getLogType($row['log_civicrm_entity_log_type']);

      $date = CRM_Utils_Date::isoToMysql($row['log_civicrm_entity_log_date']);

      if ('Update' == CRM_Utils_Array::value('log_civicrm_entity_log_action', $row)) {
        $q = "reset=1&log_conn_id={$row['log_civicrm_entity_log_conn_id']}&log_date=". $date;
        if ($this->cid) {
          $q .= '&cid=' . $this->cid;
        }

        //NYSS append instance id so we return properly
        $q .= '&instanceID='.$this->_id;

        //NYSS 7543 append altered contact and altered by name
        $q .= (!empty($row['log_civicrm_entity_altered_contact'])) ?
          '&alteredName='.$row['log_civicrm_entity_altered_contact'] :
          '';
        $q .= (!empty($row['altered_by_contact_display_name'])) ?
          '&alteredBy='.$row['altered_by_contact_display_name'] :
          '';
        $q .= (!empty($row['log_civicrm_entity_log_user_id'])) ?
          '&alteredById='.$row['log_civicrm_entity_log_user_id'] :
          '';

        $url1 = CRM_Report_Utils_Report::getNextUrl('logging/contact/detail', "{$q}&snippet=4&section=2&layout=overlay", FALSE, TRUE);
        $url2 = CRM_Report_Utils_Report::getNextUrl('logging/contact/detail', "{$q}&section=2", FALSE, TRUE);
        $row['log_civicrm_entity_log_action'] = "<a href='{$url1}' class='crm-summary-link'><div class='icon details-icon'></div></a>&nbsp;<a title='View details for this update' href='{$url2}'>" . ts('Update') . '</a>';
      }

      //CRM_Core_Error::debug_var('row',$row);
      //CRM_Core_Error::debug_var('this',$this);
      if ( $this->_showDetails ) {
        $cid = $row['log_civicrm_entity_altered_contact_id'];
        $row['show_details'] = self::getContactDetails($cid);
      }

      $key  = $date . '_' .
        $row['log_civicrm_entity_log_type'] . '_' .
        $row['log_civicrm_entity_log_conn_id'] . '_' .
        $row['log_civicrm_entity_log_user_id'] . '_' .
        $row['log_civicrm_entity_altered_contact_id'];
      $newRows[$key] = $row;

      unset($row['log_civicrm_entity_log_user_id']);
      unset($row['log_civicrm_entity_log_conn_id']);
    }

    //NYSS 7452 reorder unless flagged not to
    if ( !$this->_formOrderBy ) {
      krsort($newRows);
    }
    $rows = $newRows;
  }

  function select() {
    //NYSS get log details param and unset column
    $cols   =& $this->_columns;
    //CRM_Core_Error::debug_var('cols', $cols);

    $params = $this->_submitValues;
    //CRM_Core_Error::debug_var('params', $params);

    if ( isset($cols['log_civicrm_entity']['fields']['log_details']) &&
         $params['fields']['log_details'] ) {
      $this->_showDetails = 1;
      unset($cols['log_civicrm_entity']['fields']['log_details']);
    }

    parent::select();
  }

  function from( $logTable = null ) {
    static $entity = null;
    if ( $logTable ) {
      $entity = $logTable;
    }

    $detail = $this->_logTables[$entity];
    $tableName = CRM_Utils_Array::value('table_name', $detail, $entity);
    $clause = CRM_Utils_Array::value('entity_table', $detail);
    $clause = $clause ? "AND entity_log_civireport.entity_table = 'civicrm_contact'" : null;

    $joinClause = "
INNER JOIN civicrm_contact modified_contact_civireport
        ON (entity_log_civireport.{$detail['fk']} = modified_contact_civireport.id {$clause})";

    if (CRM_Utils_Array::value('joins', $detail)) {
      $clause = CRM_Utils_Array::value('entity_table', $detail);
      $clause = $clause ? "AND fk_table.entity_table = 'civicrm_contact'" : null;
      $joinClause = "
INNER JOIN `{$this->loggingDB}`.{$detail['joins']['table']} fk_table ON {$detail['joins']['join']}
INNER JOIN civicrm_contact modified_contact_civireport
        ON (fk_table.{$detail['fk']} = modified_contact_civireport.id {$clause})";
    }

    $this->_from = "
FROM `{$this->loggingDB}`.$tableName entity_log_civireport
{$joinClause}
LEFT  JOIN civicrm_contact altered_by_contact_civireport
        ON (entity_log_civireport.log_user_id = altered_by_contact_civireport.id)";
  }
    
  //NYSS 4198 calculate distinct contacts
  function statistics( &$rows ) {
    $distinctContacts = array();
    foreach ( $rows as $row ) {
      $distinctContacts[$row['log_civicrm_entity_altered_contact_id']] = 1;
    }
    $statistics = parent::statistics( $rows );
    $statistics['counts']['rowsFound'] = array(
      'title' => ts('Contact(s) Changed'),
      'value' => count($distinctContacts),
    );
    return $statistics;
  }

  function getContactDetails( $cid ) {
    $left = $middle = $right = array();
    $leftList = $middleList = $addressList = '';

    $IMProvider = CRM_Core_PseudoConstant::get('CRM_Core_DAO_IM', 'provider_id');

    $params = array(
      'version' => 3,
      'id' => $cid,
    );
    $contact = civicrm_api( 'contact', 'getsingle', $params );
    //CRM_Core_Error::debug('contact',$contact);

    $left['nick_name'] = "{$contact['nick_name']} (nickname)";
    $left['gender'] = "{$contact['gender']} (gender)";
    $left['job_title'] = "{$contact['job_title']} (job title)";
    $left['birth_date'] = "{$contact['birth_date']} (birthday)";

    $middle['phone'] = "{$contact['phone']} (phone)";
    $middle['email'] = "{$contact['email']} (email)";
    $middle['im'] = "{$contact['im']} ({$IMProvider[$contact['provider_id']]})";

    $address['street1'] = $contact['street_address'];
    $address['street2'] = $contact['supplemental_address_1'];
    $address['street3'] = $contact['supplemental_address_2'];
    $address['city'] = $contact['city'];
    $address['state'] = $contact['state_province'];
    $address['zip'] = $contact['postal_code'];

    //check against contact and remove if empty
    foreach ( $left as $f => $v ) {
      if ( empty($contact[$f]) ) {
        unset($left[$f]);
      }
    }
    foreach ( $middle as $f => $v ) {
      if ( empty($contact[$f]) ) {
        unset($middle[$f]);
      }
    }
    $address = array_filter($address);

    if ( !empty($left) ) {
      $leftList  = "<div class='logLeftList'><ul><li>";
      $leftList .= implode("</li>\n<li>", $left);
      $leftList .= '</li></ul></div>';
    }
    if ( !empty($middle) ) {
      $middleList  = "<div class='logMiddleList'><ul><li>";
      $middleList .= implode("</li>\n<li>", $middle);
      $middleList .= '</li></ul></div>';
    }

    if ( !empty($address) ) {
      $addressList  = "<div class='logRightList'><ul><li>";
      $addressList .= ( $address['street3'] ) ? "{$address['street3']}<br />" : '';
      $addressList .= ( $address['street1'] ) ? "{$address['street1']}<br />" : '';
      $addressList .= ( $address['street2'] ) ? "{$address['street2']}<br />" : '';
      $addressList .= "{$address['city']}, {$address['state']} {$address['zip']}";
      $addressList .= '</li></ul></div>';
    }

    $html = $leftList.$middleList.$addressList;
    //CRM_Core_Error::debug_var('html',$html);

    return $html;
  }
}
