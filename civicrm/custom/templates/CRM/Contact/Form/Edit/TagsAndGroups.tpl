{*
 +--------------------------------------------------------------------+
 | CiviCRM version 4.2                                                |
 +--------------------------------------------------------------------+
 | Copyright CiviCRM LLC (c) 2004-2012                                |
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
{literal}
<link type="text/css" rel="stylesheet" media="screen,projection" href="/sites/default/themes/Bluebird/nyss_skin/tags/tags.css" />
<script src="/sites/default/themes/Bluebird/scripts/bbtree.js" type="text/javascript"></script>
<script>
BBTree.startInstance({displaySettings:{writeSets: [291], treeTypeSet: 'tagging'}});
</script>
{/literal}
{if $title}
<div id="dialog">

</div>
<div class="crm-accordion-wrapper crm-tagGroup-accordion crm-accordion-closed">
 <div class="crm-accordion-header">
  <div class="icon crm-accordion-pointer"></div> 
	<a href="#" class="whiteanchor">{$title}</a>
  </div><!-- /.crm-accordion-header -->
  <div class="crm-accordion-body" id="tagGroup">
{/if}

    <table class="form-layout-compressed{if $context EQ 'profile'} crm-profile-tagsandgroups{/if}" style="width:98%">
	
	    {foreach key=key item=item from=$tagGroup}
		{* $type assigned from dynamic.tpl *}
		{if !$type || $type eq $key }
		
			{if $key eq 'tag'}
			<tr>
				<td width="100%" class="crm-tagList"><div class="label" onClick="rollDownGroup('.crm-tagList');"><div class="arrow"></div>{if $title}{$form.$key.label}{/if}</div>
				    <div id="crm-tagListWrap">
						<div class="groupTagsKeywords">{include file="CRM/common/Tag.tpl"}</div>
					</div>
					
				</td>
			</tr>
			{/if}
			{if $key eq 'group'}
			<tr>
				<td width="100%" class="crm-tagGroupsList"><div class="label" onClick="rollDownGroup('.crm-tagGroupsList');"><div class="arrow"></div>{if $title}{$form.$key.label}{/if}</div>
				    <div id="crm-tagListWrap">
					    <table id="crm-tagGroupTable">
						{foreach key=k item=it from=$form.$key}
						    {if $k|is_numeric}
							<tr class={cycle values="'odd-row','even-row'" name=$key} id="crm-tagRow{$k}">
							    <td>
			                   			<strong>{$it.html}</strong><br /> {*LCD retain for groups list*}
								{if $item.$k.description}
								    <div class="description">
									{$item.$k.description}
								    </div>
								{/if}
							    </td>
							</tr>
						    {/if}
						{/foreach}   
					    </table>
				    </div>
				</td>
			</tr>
			<tr></tr>
			{/if}
		{/if}
	    {/foreach}
	
    </table>   
{if $title}
 </div><!-- /.crm-accordion-body -->
</div><!-- /.crm-accordion-wrapper -->

{/if}
