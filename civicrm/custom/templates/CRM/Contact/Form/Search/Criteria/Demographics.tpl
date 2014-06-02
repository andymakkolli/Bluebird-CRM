{*
 +--------------------------------------------------------------------+
 | CiviCRM version 4.4
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
*}
{*NYSS 7906 completely different layout; add birth date month*}
<div id="demographics" class="form-item">
  <table class="form-layout">
    <tr>
      <td><label>{ts}Birth Dates{/ts}</label></td>
      <td></td>
      <td><label>{$form.birth_date_month.label}</label></td>
      <td></td>
    </tr>
    <tr>
      {include file="CRM/Core/DateRange.tpl" fieldName="birth_date" from='_low' to='_high'}
      <td>{$form.birth_date_month.html}</td>
      <td></td>
    </tr>
    <tr>
      <td><label>{$form.is_deceased.label}</label></td>
      <td></td>
      <td><label>{ts}Deceased Dates{/ts}</label></td>
      <td></td>
    </tr>
    <tr>
      <td>
        {$form.is_deceased.html}
        <span class="crm-clear-link">(<a href="#" title="unselect" onclick="unselectRadio('is_deceased', 'Advanced'); return false;" >{ts}clear{/ts}</a>)</span>
      </td>
      <td></td>
      {include file="CRM/Core/DateRange.tpl" fieldName="deceased_date" from='_low' to='_high'}
    </tr>
    <tr>
      <td>
        {$form.gender_id.label}<br />
        {$form.gender_id.html}<span class="crm-clear-link">(<a href="#" title="unselect" onclick="unselectRadio('gender_id', 'Advanced'); return false;" >{ts}clear{/ts}</a>)</span>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
</div>
