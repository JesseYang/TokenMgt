$ ->
  if window.platform == "dropbox"
    $(".dropbox-link").trigger 'click'
  if window.platform == "onedrive"
    $(".onedrive-link").trigger 'click'
  if window.platform == "googledrive"
    $(".googledrive-link").trigger 'click'

  $(".edit-account").click ->
    $("#edit-account").modal('show')
    tr = $(this).closest('tr')
    platform = tr.attr("data-platform")
    $("#edit-account .title").text("编辑 " + platform + " 账户")
    $("#edit-account #platform").val(platform)
    $("#edit-account #account").val(tr.find(".account").text())
    $("#edit-account #password").val(tr.find(".password").text())
    $("#edit-account form").attr("action", "/accounts/" + tr.attr("data-id"))


  $(".refresh-btn").click ->
    $(this).attr("disabled", "true")
    window.location.href = "/tokens/refresh"
