<?php

/*
 +--------------------------------------------------------------------+
 | CiviCRM version 4.1                                                |
 +--------------------------------------------------------------------+
 | Copyright CiviCRM LLC (c) 2004-2011                                |
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
 * @copyright CiviCRM LLC (c) 2004-2011
 * $Id$
 *
 */


/**
 * This is base class for all ajax calls
 */
class CRM_Core_Page_AJAX {

    /**
     * function to call generic ajax forms
     *
     * @static
     * @access public
     */ 
    static function run() {
        $className =  CRM_Utils_Type::escape( $_POST['class_name'], 'String' );
        $type = '';
        if ( CRM_Utils_Array::value( 'type', $_POST ) ) {
          $type = CRM_Utils_Type::escape( $_POST['type'], 'String' );
        }

        if ( !$className ) {
            CRM_Core_Error::fatal( ts('Invalid className: %1', array( 1 => $className )) );
        }

        //NYSS remove with autoload
        require_once 'CRM/Contact/Form/Inline/Email.php';
        require_once 'CRM/Contact/Page/Inline/Email.php';
        require_once 'CRM/Contact/Form/Inline/Phone.php';
        require_once 'CRM/Contact/Page/Inline/Phone.php';

        if ( !$type ) {
          $wrapper = new CRM_Utils_Wrapper( );
          $wrapper->run( $className );
        } 
        else {
          eval("{$className}::run();");
        }
        CRM_Utils_System::civiExit( );    
    }
}