<tr>
  <td>
    {$form.mailing_id.label}
    <br />
    {$form.mailing_id.html}
    {literal}
    <script type="text/javascript">
      cj("select#mailing_id").crmasmSelect({
        addItemTarget: 'bottom',
        animate: false,
        highlight: true,
        sortable: true
      });
    </script>
    {/literal}
  </td>
  {*NYSS 4845*}
  <td>
    {$form.mailing_subject.label}
    <br />
    {$form.mailing_subject.html}
  </td>
  <td>
    {$form.mailing_job_status.label}
    <br />
    {$form.mailing_job_status.html}
  </td>
</tr>
<tr><td><label>{ts}Mailing Date{/ts}</label></td></tr>
<tr>
	{include file="CRM/Core/DateRange.tpl" fieldName="mailing_date" from='_low' to='_high'}
</tr>
<tr>
  <td>
    {$form.mailing_delivery_status.label}
    <br />
    {$form.mailing_delivery_status.html}
    <span class="crm-clear-link">
      (<a href="#" onclick="unselectRadio('mailing_delivery_status','{$form.formName}'); return false;">{ts}clear{/ts}</a>)
    </span>
  <br />
  {$form.mailing_bounce_types.label}
  {$form.mailing_bounce_types.html}
  {literal}
    <script type="text/javascript">
      cj("select#mailing_bounce_types").crmasmSelect({
        addItemTarget: 'bottom',
        animate: false,
        highlight: true,
        sortable: true
      });
    </script>
   {/literal}
  </td>
  <td>
    {$form.mailing_open_status.label}
    <br />
    {$form.mailing_open_status.html}
    <span class="crm-clear-link">
      (<a href="#" onclick="unselectRadio('mailing_open_status','{$form.formName}'); return false;">{ts}clear{/ts}</a>)
    </span>
  </td>
</tr>
<tr>
  <td>
    {$form.mailing_click_status.label}
    <br />
    {$form.mailing_click_status.html}
    <span class="crm-clear-link">
      (<a href="#" onclick="unselectRadio('mailing_click_status','{$form.formName}'); return false;">{ts}clear{/ts}</a>)
    </span>
  </td>
  <td>
    {$form.mailing_reply_status.label}
    <br />
    {$form.mailing_reply_status.html}
    <span class="crm-clear-link">
      {*NYSS 7378*}
      (<a href="#" onclick="unselectRadio('mailing_reply_status','{$form.formName}'); return false;">{ts}clear{/ts}</a>)
    </span>
  </td>
</tr>
<tr>
  <td>
    <table>
      <tr>
         {$form.mailing_unsubscribe.html}&nbsp;
         {$form.mailing_unsubscribe.label}
      </tr>
    </table>
  </td>
  <td>
    <table>
      <tr>
         <td>
            {$form.mailing_optout.html}&nbsp;
            {$form.mailing_optout.label}
         </td>
         <td>
            {$form.mailing_forward.html}&nbsp;
            {$form.mailing_forward.label}
         </td>
      </tr>
    </table>
  </td>
</tr>
