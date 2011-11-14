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
{*NYSS modifications throughout to present all core fields in left col and custom fields in right*}
<div id="location" class="form-item">
    <table class="form-layout">
	<tr>
        <td>
           {$form.location_type.label}<br />
           {$form.location_type.html} 
           <div class="description" >
             {ts}Location search uses the PRIMARY location for each contact by default.{/ts}<br /> 
             {ts}To search by specific location types (e.g. Home, Work...), check one or more boxes above.{/ts}
           </div> 
        </td>
        {if $addressGroupTree}
	      <td rowspan="3">
	        {include file="CRM/Custom/Form/Search.tpl" groupTree=$addressGroupTree showHideLinks=false}
          </td>
    	{/if}	   
    </tr>
    
    {*NYSS move street/city*}
    <tr>
    	<td>
        <table cellpadding="inner-table">
        	<tr>
             <td>{$form.street_address.label}<br />
             {*NYSS*}
            	 <span id="streetAddress">
 	               {$form.street_address.html|crmReplace:class:big}<br />
 	               {if $parseStreetAddress}
 	                 &nbsp;&nbsp;<a href="#" title="{ts}Use Address Elements{/ts}" onClick="processAddressFields( 'addressElements' , 1 );return false;">{ts}Use Address Elements{/ts}</a>
 	             </span>
 	             <span id="addressElements" class=hiddenElement>
 	               {$form.street_number.html}&nbsp;{$form.street_name.html}&nbsp;{$form.street_unit.html}<br />
 	               <a href="#" title="{ts}Use Street Address{/ts}" onClick="processAddressFields( 'streetAddress', 1 );return false;">{ts}Use Street Address{/ts}</a>
                   {/if}
 	             </span>
             </td>
             <td>{$form.city.label}<br />
            	 {$form.city.html}
             </td>
            </tr>
        </table>
        </td>
    </tr>
           
    <tr>
        <td>
		<table class="inner-table">
		   <tr>
			<td>
			     {$form.postal_code.label}<br />
                             {$form.postal_code.html}
			</td>
			<td>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<label>{ts}OR{/ts}</label>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
			<td><label>{ts}Postal Code{/ts}</label>
				{$form.postal_code_low.label|replace:'-':'<br />'}
		                &nbsp;&nbsp;{$form.postal_code_low.html|crmReplace:class:six}
                                {$form.postal_code_high.label}
                		&nbsp;&nbsp;{$form.postal_code_high.html|crmReplace:class:six}
			</td>
		    </tr>
		    <tr>
            <td colspan="3">{$form.prox_distance.label}<br />{$form.prox_distance.html}&nbsp;{$form.prox_distance_unit.html}</td>
            </tr>

		    <tr>
			<td colspan="2">{$form.state_province.label}<br />
            {$form.state_province.html|crmReplace:class:bigSelect}
			</td>        
			<td>{$form.country.label}<br />
				{$form.country.html|crmReplace:class:big}&nbsp;
			</td>
		    </tr>
		</table>
        </td>
    </tr>
    </table>
</div>

{*NYSS*}
{if $parseStreetAddress eq 1}
{literal}
<script type="text/javascript">
function processAddressFields( name, loadData ) {
        if ( name == 'addressElements' ) {
             if ( loadData ) {
                  cj( '#street_address' ).val( '' );
             }
             
             showBlockName = 'addressElements';
             hideBlockName = 'streetAddress';
        } else {
             if ( loadData ) {
                  cj( '#street_name'   ).val( '' );
				  cj( '#street_unit'   ).val( '' );
				  cj( '#street_number' ).val( '' );
             }

             showBlockName = 'streetAddress';
             hideBlockName = 'addressElements';
       }

       show( showBlockName );
       hide( hideBlockName );
}

cj(function( ) {
  if (  cj('#street_name').val( ).length > 0 ||
        cj('#street_unit').val( ).length > 0 ||
        cj('#street_number').val( ).length > 0 ) {
    processAddressFields( 'addressElements', 1 );
  }
}
);

</script>
{/literal}
{/if}
