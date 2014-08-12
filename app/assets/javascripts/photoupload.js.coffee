view_upload_details = (upload) ->
  # Build an html table out of the upload object
  rows = []
  $.each upload, (k, v) ->
    rows.push $("<tr>").append($("<td>").text(k)).append($("<td>").text(JSON.stringify(v)))
    return

  $("#info").html $("<div class=\"upload_details\">").append("<h2>Upload metadata:</h2>").append($("<table>").append(rows))
  return

$(document).ready ->
  $(".cloudinary-fileupload").fileupload(
    dropZone: "#direct_upload"
    start: (e) ->
      $(".status").text "Starting upload..."
      return

    progress: (e, data) ->
      $(".status").text "Uploading... " + Math.round((data.loaded * 100.0) / data.total) + "%"
      return

    fail: (e, data) ->
      $(".status").text "Upload failed"
      return
  ).off("cloudinarydone").on "cloudinarydone", (e, data) ->
    $("#photo_bytes").val data.result.bytes
    $(".status").text ""
    preview = $(".preview").html("")
    $.cloudinary.image(data.result.public_id,
      format: data.result.format
      width: 200
      height: 200
      crop: "fit"
    ).appendTo preview
    $("<a/>").addClass("delete_by_token").attr(href: "#").data(delete_token: data.result.delete_token).html("&times;").appendTo(preview).click (e) ->
      e.preventDefault()
      $.cloudinary.delete_by_token($(this).data("delete_token")).done(->
        $(".preview").html ""
        $("#info").html ""
        $("#photo_bytes").val ""
        $("input[name=\"photo[image]\"]").remove()
        return
      ).fail ->
        $(".status").text "Cannot delete image"
        return

      return

    view_upload_details data.result
    return

  return
