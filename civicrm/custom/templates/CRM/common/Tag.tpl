{if !$tagsetType or $tagsetType eq 'contact'}
  {foreach from=$tagsetInfo_contact item=tagset}
  <div class="crm-section tag-section contact-tagset-{$tagset.parentID}-section">
    {*NYSS*}
    <div class="label">
      <label>{$tagset.parentName}</label>
    </div>
    <div{if $context EQ "contactTab"} style="margin-top:-15px;"{/if}>
      {assign var=elemName  value = $tagset.tagsetElementName}
      {assign var=parID     value = $tagset.parentID}
      {assign var=editTagSet value=false}
      {$form.$elemName.$parID.html}
      {if $action ne 4 }
        {assign var=editTagSet value=true}
        {if $action eq 16 and !($permission eq 'edit') }
          {assign var=editTagSet value=false}
        {/if}
      {/if}
      {if $editTagSet}
        <script type="text/javascript">
          {literal}
          var tagUrl = {/literal}"{$tagset.tagUrl}&key={crmKey name='civicrm/ajax/taglist'}"{literal};
          var contactEntityTags = '';
          {/literal}{if $tagset.entityTags}{literal}
            eval( 'contactEntityTags = ' + {/literal}'{$tagset.entityTags}'{literal} );
          {/literal}{/if}{literal}
          var hintText = "{/literal}{ts escape='js'}Type in a partial or complete name of an existing tag.{/ts}{literal}";

          cj( ".contact-tagset-{/literal}{$tagset.parentID}{literal}-section:not(.crm-processed-input) input")
            .addClass("contact-taglist_{/literal}{$tagset.parentID}{literal}");
          cj( ".contact-tagset-{/literal}{$tagset.parentID}{literal}-section:not(.crm-processed-input) .contact-taglist_{/literal}{$tagset.parentID}{literal}"  )
            .tokenInput( tagUrl, {
              prePopulate: contactEntityTags,
              theme: 'facebook',
              hintText: hintText,
              onAdd: function ( item ) {
                // NYSS-6558 Check to prevent submitting empty tags
                // An empty tag is submitted as ':::value'
                // we check for a tag starting with ::: and ignore it
                if(cj.trim(item.id).substring(0,3) != ":::"){
                  processContactTags_{/literal}{$tagset.parentID}{literal}( 'select', cj.trim(item.id ));
                  //NYSS update count of tags in summary tab
                  if ( cj( '.ui-tabs-nav #tab_tag a' ).length ) {
                    var tagCount = cj('.ui-tabs-nav #tab_tag a em').html();
                    tagCount++;
                    cj( '.ui-tabs-nav #tab_tag a em' ).html(tagCount);
                  }
                }else{
                  CRM.alert(ts('Keywords must contain content, blank spaces are not accepted'), ts('Warning'), 'warning');
                  cj('.contact-tagset-296-section li.token-input-token-facebook').last().remove();
                }

              },
              onDelete: function ( item ) {
                processContactTags_{/literal}{$tagset.parentID}{literal}( 'delete', item.id );
                //NYSS update count of tags in summary tab
                if ( cj( '.ui-tabs-nav #tab_tag a' ).length ) {
                  var tagCount = cj('.ui-tabs-nav #tab_tag a em').html();
                  tagCount--;
                  cj( '.ui-tabs-nav #tab_tag a em' ).html(tagCount);
                }
              }
            }
          );

          cj( ".contact-tagset-{/literal}{$tagset.parentID}{literal}-section:not(.crm-processed-input)").addClass("crm-processed-input");

          function processContactTags_{/literal}{$tagset.parentID}{literal}( action, id ) {
            var postUrl          = "{/literal}{crmURL p='civicrm/ajax/processTags' h=0}{literal}";
            var parentId         = "{/literal}{$tagset.parentID}{literal}";
            var entityId         = "{/literal}{$tagset.entityId}{literal}";
            var entityTable      = "{/literal}{$tagset.entityTable}{literal}";
            var skipTagCreate    = "{/literal}{$tagset.skipTagCreate}{literal}";
            var skipEntityAction = "{/literal}{$tagset.skipEntityAction}{literal}";

            cj.post( postUrl, { action: action, tagID: id, parentId: parentId, entityId: entityId, entityTable: entityTable,
              skipTagCreate: skipTagCreate, skipEntityAction: skipEntityAction, key: {/literal}"{crmKey name='civicrm/ajax/processTags'}"{literal} },
              function ( response ) {
                // update hidden element
                if ( response.id ) {
                  var curVal   = cj( ".contact-taglist_{/literal}{$tagset.parentID}{literal}" ).val( );
                  var valArray = curVal.split(',');
                  var setVal   = Array( );
                  if ( response.action == 'delete' ) {
                    for ( x in valArray ) {
                      if ( valArray[x] != response.id ) {
                        setVal[x] = valArray[x];
                      }
                    }
                    if (!skipEntityAction) {
                    CRM.alert('', '{/literal}{ts escape='js'}Removed{/ts}{literal}', 'success');
                  }
                  }
                  else {
                    CRM.alert('', '{/literal}{ts escape='js'}Saved{/ts}{literal}', 'success');
                  }
                  if ( response.action == 'select' ) {
                    setVal    = valArray;
                    setVal[ setVal.length ] = response.id;
                  }

                  var actualValue = setVal.join( ',' );
                  cj( ".contact-taglist_{/literal}{$tagset.parentID}{literal}" ).val( actualValue );
                }
                // update contact summary tab
                if (CRM.updateContactSummaryTags) {
                  CRM.updateContactSummaryTags();
                }
              },
            "json" );
          }
          {/literal}
        </script>
      {else}
        {if $tagset.entityTagsArray}
          {foreach from=$tagset.entityTagsArray item=val name="tagsetList"}
            &nbsp;{$val.name}{if !$smarty.foreach.tagsetList.last},{/if}
          {/foreach}
        {/if}
      {/if}
    </div>
    <div class="clear"></div>
  </div>
{if $action eq 16 || $action eq 2 || $action eq 1}
    {if $tagset.parentID eq 296}
        <div class="BBInit">
          <div class="crm-section tag-section contact-tagset-291-section crm-processed-input">
            <div class="tag-label">
                <label>Issue Codes</label>
            </div>
            <input type="text" autocomplete="off" placeholder="Type here to search issue codes" maxlength="64" id="issue-code-search" />
            <div id="issue-code-results" class="TreeWrap" data-contact="{$contactId}"></div>
           </div>
          </div>
        {literal}
        <script>
            var tree = new TagTreeTag({
              tree_container: cj('#issue-code-results'),
              list_container: cj('.contactTagsList'),
              filter_bar: cj('#issue-code-search'),
              tag_trees: [291],
              default_tree: 291,
              auto_save: true,
              entity_id: cj('#issue-code-results').data('contact'),
              entity_counts: false,
              entity_type: 'civicrm_contact',
            });
            tree.load();
        </script>
        {/literal}
    {/if}
{/if}
  {/foreach}

{elseif $tagsetType eq 'activity'}
  {foreach from=$tagsetInfo_activity item=tagset}
  <div class="crm-section tag-section activity-tagset-{$tagset.parentID}-section">
    <div class="tag-label">
      <label>{$tagset.parentName}</label>
    </div>
    <div class="content">
      {assign var=elemName  value = $tagset.tagsetElementName}
      {assign var=parID     value = $tagset.parentID}
      {assign var=editTagSet value=false}
      {$form.$elemName.$parID.html}
      {if $action ne 4 }
        {assign var=editTagSet value=true}
        {if $action eq 16 and !($permission eq 'edit') }
          {assign var=editTagSet value=false}
        {/if}
      {/if}
      {if $editTagSet}
        <script type="text/javascript">
          {literal}
          var tagUrl = {/literal}"{$tagset.tagUrl}&key={crmKey name='civicrm/ajax/taglist'}"{literal};
          var activityEntityTags = '';
          {/literal}{if $tagset.entityTags}{literal}
            eval( 'activityEntityTags = ' + {/literal}'{$tagset.entityTags}'{literal} );
          {/literal}{/if}{literal}
          var hintText = "{/literal}{ts escape='js'}Type in a partial or complete name of an existing tag.{/ts}{literal}";

          cj( ".activity-tagset-{/literal}{$tagset.parentID}{literal}-section:not(.crm-processed-input) input")
            .addClass("activity-taglist_{/literal}{$tagset.parentID}{literal}");

          cj( ".activity-tagset-{/literal}{$tagset.parentID}{literal}-section:not(.crm-processed-input) .activity-taglist_{/literal}{$tagset.parentID}{literal}"  )
            .tokenInput( tagUrl, {
              prePopulate: activityEntityTags,
              theme: 'facebook',
              hintText: hintText,
              onAdd: function ( item ) {
                processActivityTags_{/literal}{$tagset.parentID}{literal}( 'select', item.id );
              },
              onDelete: function ( item ) {
                processActivityTags_{/literal}{$tagset.parentID}{literal}( 'delete', item.id );
              }
            }
          );

          cj( ".activity-tagset-{/literal}{$tagset.parentID}{literal}-section:not(.crm-processed-input)").addClass("crm-processed-input");
          function processActivityTags_{/literal}{$tagset.parentID}{literal}( action, id ) {
            var postUrl          = "{/literal}{crmURL p='civicrm/ajax/processTags' h=0}{literal}";
            var parentId         = "{/literal}{$tagset.parentID}{literal}";
            var entityId         = "{/literal}{$tagset.entityId}{literal}";
            var entityTable      = "{/literal}{$tagset.entityTable}{literal}";
            var skipTagCreate    = "{/literal}{$tagset.skipTagCreate}{literal}";
            var skipEntityAction = "{/literal}{$tagset.skipEntityAction}{literal}";

            cj.post( postUrl, { action: action, tagID: id, parentId: parentId, entityId: entityId, entityTable: entityTable,
              skipTagCreate: skipTagCreate, skipEntityAction: skipEntityAction, key: {/literal}"{crmKey name='civicrm/ajax/processTags'}"{literal} },
              function ( response ) {
                // update hidden element
                if ( response.id ) {
                  var curVal   = cj( ".activity-taglist_{/literal}{$tagset.parentID}{literal}" ).val( );
                  var valArray = curVal.split(',');
                  var setVal   = Array( );
                  if ( response.action == 'delete' ) {
                    for ( x in valArray ) {
                      if ( valArray[x] != response.id ) {
                        setVal[x] = valArray[x];
                      }
                    }
                  }
                  else if ( response.action == 'select' ) {
                    setVal    = valArray;
                    setVal[ setVal.length ] = response.id;
                  }

                  var actualValue = setVal.join( ',' );
                  cj( ".activity-taglist_{/literal}{$tagset.parentID}{literal}" ).val( actualValue );
                }
              },
            "json" );
          }
          {/literal}
        </script>
      {else}
        {if $tagset.entityTagsArray}
          {foreach from=$tagset.entityTagsArray item=val name="tagsetList"}
            &nbsp;{$val.name}{if !$smarty.foreach.tagsetList.last},{/if}
          {/foreach}
        {/if}
      {/if}
    </div>
    <div class="clear"></div>
  </div>
  {/foreach}

{elseif $tagsetType eq 'case'}
  {foreach from=$tagsetInfo_case item=tagset}
  <div class="crm-section tag-section case-tagset-{$tagset.parentID}-section">
    <div class="label">
      <label>{$tagset.parentName}</label>
    </div>
    <div class="content">
      {assign var=elemName  value = $tagset.tagsetElementName}
      {assign var=parID     value = $tagset.parentID}
      {assign var=editTagSet value=false}
      {$form.$elemName.$parID.html}
      {if $action ne 4 or $form.formName eq 'CaseView' }
        {assign var=editTagSet value=true}
        {if $action eq 16 and !($permission eq 'edit') }
          {assign var=editTagSet value=false}
        {/if}
      {/if}
      {if $editTagSet}
        <script type="text/javascript">
          {literal}
          var tagUrl = {/literal}"{$tagset.tagUrl}&key={crmKey name='civicrm/ajax/taglist'}"{literal};
          var caseEntityTags = '';
          {/literal}{if $tagset.entityTags}{literal}
            eval( 'caseEntityTags = ' + {/literal}'{$tagset.entityTags}'{literal} );
          {/literal}{/if}{literal}
          var hintText = "{/literal}{ts escape='js'}Type in a partial or complete name of an existing tag.{/ts}{literal}";

          cj( ".case-tagset-{/literal}{$tagset.parentID}{literal}-section:not(.crm-processed-input) input")
            .addClass("case-taglist_{/literal}{$tagset.parentID}{literal}");

          cj( ".case-tagset-{/literal}{$tagset.parentID}{literal}-section:not(.crm-processed-input) .case-taglist_{/literal}{$tagset.parentID}{literal}")
            .tokenInput( tagUrl, {
              prePopulate: caseEntityTags,
              theme: 'facebook',
              hintText: hintText,
              onAdd: function ( item ) {
                processCaseTags_{/literal}{$tagset.parentID}{literal}( 'select', item.id );
              },
              onDelete: function ( item ) {
                processCaseTags_{/literal}{$tagset.parentID}{literal}( 'delete', item.id );
              }
            }
          );

          cj( ".case-tagset-{/literal}{$tagset.parentID}{literal}-section:not(.crm-processed-input)").addClass("crm-processed-input");

          function processCaseTags_{/literal}{$tagset.parentID}{literal}( action, id ) {
            var postUrl          = "{/literal}{crmURL p='civicrm/ajax/processTags' h=0}{literal}";
            var parentId         = "{/literal}{$tagset.parentID}{literal}";
            var entityId         = "{/literal}{$tagset.entityId}{literal}";
            var entityTable      = "{/literal}{$tagset.entityTable}{literal}";
            var skipTagCreate    = "{/literal}{$tagset.skipTagCreate}{literal}";
            var skipEntityAction = "{/literal}{$tagset.skipEntityAction}{literal}";

            cj.post( postUrl, { action: action, tagID: id, parentId: parentId, entityId: entityId, entityTable: entityTable,
              skipTagCreate: skipTagCreate, skipEntityAction: skipEntityAction, key: {/literal}"{crmKey name='civicrm/ajax/processTags'}"{literal} },
              function ( response ) {
                // update hidden element
                if ( response.id ) {
                  var curVal   = cj( ".case-taglist_{/literal}{$tagset.parentID}{literal}" ).val( );
                  var valArray = curVal.split(',');
                  var setVal   = Array( );
                  if ( response.action == 'delete' ) {
                    for ( x in valArray ) {
                      if ( valArray[x] != response.id ) {
                        setVal[x] = valArray[x];
                      }
                    }
                  }
                  else if ( response.action == 'select' ) {
                    setVal    = valArray;
                    setVal[ setVal.length ] = response.id;
                  }

                  var actualValue = setVal.join( ',' );
                  cj( ".case-taglist_{/literal}{$tagset.parentID}{literal}" ).val( actualValue );
                }
              },
            "json" );
          }
          {/literal}
        </script>
      {else}
        {if $tagset.entityTagsArray}
          {foreach from=$tagset.entityTagsArray item=val name="tagsetList"}
            &nbsp;{$val.name}{if !$smarty.foreach.tagsetList.last},{/if}
          {/foreach}
        {/if}
      {/if}
    </div>
    <div class="clear"></div>
  </div>
  {/foreach}
{elseif $tagsetType eq 'attachment'}
  {assign var=tagset     value = $tagsetInfo_attachment.$tagsetNumber}
  <div class="crm-section tag-section attachment-tagset-{$tagset.parentID}-section">
    <div class="crm-attachment-tagset-label">
      <label>{$tagset.parentName}</label>
    </div>
    <div class="crm-attachment-tagset">
      {assign var=elemName  value = $tagset.tagsetElementName}
      {assign var=parID     value = $tagset.parentID}
      {assign var=editTagSet value=false}
      {$form.$elemName.$parID.html}
      {if $action ne 4 or $form.formName eq 'CaseView' }
        {assign var=editTagSet value=true}
        {if $action eq 16 and !($permission eq 'edit') }
          {assign var=editTagSet value=false}
        {/if}
      {/if}
      {if $editTagSet}
        <script type="text/javascript">
          {literal}
          var tagUrl = {/literal}"{$tagset.tagUrl}&key={crmKey name='civicrm/ajax/taglist'}"{literal};
          var attachmentEntityTags = '';
          {/literal}{if $tagset.entityTags}{literal}
            eval( 'attachmentEntityTags = ' + {/literal}'{$tagset.entityTags}'{literal} );
          {/literal}{/if}{literal}
          var hintText = "{/literal}{ts escape='js'}Type in a partial or complete name of an existing tag.{/ts}{literal}";

          cj( ".attachment-tagset-{/literal}{$tagset.parentID}{literal}-section:not(.crm-processed-input) input")
            .addClass("attachment-taglist_{/literal}{$tagset.parentID}{literal}");

          cj( ".attachment-tagset-{/literal}{$tagset.parentID}{literal}-section:not(.crm-processed-input) .attachment-taglist_{/literal}{$tagset.parentID}{literal}")
            .tokenInput( tagUrl, {
              prePopulate: attachmentEntityTags,
              theme: 'facebook',
              hintText: hintText,
              onAdd: function ( item ) {
                processAttachmentTags_{/literal}{$tagset.parentID}{literal}( 'select', item.id );
              },
              onDelete: function ( item ) {
                processAttachmentTags_{/literal}{$tagset.parentID}{literal}( 'delete', item.id );
              }
            }
          );

          cj( ".attachment-tagset-{/literal}{$tagset.parentID}{literal}-section:not(.crm-processed-input)").addClass("crm-processed-input");

          function processAttachmentTags_{/literal}{$tagset.parentID}{literal}( action, id ) {
            var postUrl          = "{/literal}{crmURL p='civicrm/ajax/processTags' h=0}{literal}";
            var parentId         = "{/literal}{$tagset.parentID}{literal}";
            var entityId         = "{/literal}{$tagset.entityId}{literal}";
            var entityTable      = "{/literal}{$tagset.entityTable}{literal}";
            var skipTagCreate    = "{/literal}{$tagset.skipTagCreate}{literal}";
            var skipEntityAction = "{/literal}{$tagset.skipEntityAction}{literal}";

            cj.post( postUrl, { action: action, tagID: id, parentId: parentId, entityId: entityId, entityTable: entityTable,
              skipTagCreate: skipTagCreate, skipEntityAction: skipEntityAction, key: {/literal}"{crmKey name='civicrm/ajax/processTags'}"{literal} },
              function ( response ) {
                // update hidden element
                if ( response.id ) {
                  var curVal   = cj( ".attachment-taglist_{/literal}{$tagset.parentID}{literal}" ).val( );
                  var valArray = curVal.split(',');
                  var setVal   = Array( );
                  if ( response.action == 'delete' ) {
                    for ( x in valArray ) {
                      if ( valArray[x] != response.id ) {
                        setVal[x] = valArray[x];
                      }
                    }
                  }
                  else if ( response.action == 'select' ) {
                    setVal    = valArray;
                    setVal[ setVal.length ] = response.id;
                  }

                  var actualValue = setVal.join( ',' );
                  cj( ".attachment-taglist_{/literal}{$tagset.parentID}{literal}" ).val( actualValue );
                }
              },
            "json");
          }
          {/literal}
        </script>
        {else}
        {if $tagset.entityTagsArray}
          {foreach from=$tagset.entityTagsArray item=val name="tagsetList"}
            &nbsp;{$val.name}{if !$smarty.foreach.tagsetList.last},{/if}
          {/foreach}
        {/if}
      {/if}
    </div>
    <div class="clear"></div>
  </div>
{/if}

{literal}
<script type="text/javascript">
  //NYSS 3550
  cj('input#token-input-contact_taglist_296').keydown(function(e){
    //if it's too long and the key pressed isn't backspace or delete
    if(cj(this).val().length > 63 && e.which !== 8 && e.which !== 46){
      alert("Keywords may have a maximum length of 64 characters. \nPlease reduce the size of your tag before selecting and saving it.");
      return false;
    }
  }).bind('paste', function(e){
    var el = cj(this);
    setTimeout(function() {
      var txtLen = cj(el).val().length;
      if(cj(el).val().length == 64 && e.which !== 8 && e.which !== 46){
        alert("Keywords may have a maximum length of 64 characters. \nIf you have pasted tag text exceeding that size it has been truncated. \nPlease review the value and consider reducing the length.");
        return false;
      }
    }, 100);
  });
</script>
{/literal}
