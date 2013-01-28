{*
 +--------------------------------------------------------------------+
 | CiviCRM version 3.4                                                |
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
*}
{* This file provides the plugin for the phone block *}
{* @var $form Contains the array for the form elements and other form associated information assigned to the template by the controller*}
{* @var blockId Contains the current block id, and assigned in the CRM/Contact/Form/Location.php file *}

{if !$addBlock}
    <tr>
	<td>{ts}Phone{/ts}
	    &nbsp;&nbsp;<a id='addPhone' href="#" title={ts}Add{/ts} onClick="buildAdditionalBlocks( 'Phone', '{$className}');return false;">{ts}add{/ts}</a>
	</td>
	{if $className eq 'CRM_Contact_Form_Contact'}
	    <td colspan="2"></td>
	    <td id="Phone-Primary" class="hiddenElement">{ts}Primary?{/ts}</td>
	{/if}
    </tr>
{/if}
<tr id="Phone_Block_{$blockId}">
    <td>{$form.phone.$blockId.phone.html}&nbsp;&nbsp;{ts}ext.{/ts}&nbsp;{$form.phone.$blockId.phone_ext.html|crmReplace:class:four}&nbsp;&nbsp;&nbsp;{$form.phone.$blockId.location_type_id.html}</td>
    <td colspan="2">{$form.phone.$blockId.phone_type_id.html}</td>
    <td align="center" id="Phone-Primary-html" {if $blockId eq 1}class="hiddenElement"{/if}>{$form.phone.$blockId.is_primary.1.html}</td>
    {if $blockId gt 1}
	<td><a href="#" title="{ts}Delete Phone Block{/ts}" onClick="removeBlock('Phone','{$blockId}'); return false;">{ts}delete{/ts}</a></td>
    {/if}
</tr>

{*NYSS 1748*}
{literal}
<script type="text/javascript">
cj(function( ) {
    /*var elementId = "{/literal}#phone_{$blockId}_phone{literal}";
    cj( elementId ).blur( function( ) {
        if ( cj(this).hasClass('valid') ) {
            var currentValue = cj(this).val();
            if ( currentValue ) {
                currentValue = currentValue.replace(/[^\d]/g, "");
                var formattedValue = currentValue.substr(0,3) + '-' + currentValue.substr(3,3) + '-' + currentValue.substr(6,4);
                cj(this).val( formattedValue );
            }
        }
    });*/
}); 
</script>
{/literal}