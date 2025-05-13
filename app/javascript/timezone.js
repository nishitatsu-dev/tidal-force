document.addEventListener("DOMContentLoaded", function() {
  const first_form = document.forms[0];
  first_form.timezone.value = Intl.DateTimeFormat().resolvedOptions().timeZone;
});
