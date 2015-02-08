$ ->
  fileUploadErrors =
    maxFileSize: 'File is too big',
    minFileSize: 'File is too small',
    acceptFileTypes: 'Filetype not allowed',
    maxNumberOfFiles: 'Max number of files exceeded',
    uploadedBytes: 'Uploaded bytes exceed file size',
    emptyResult: 'Empty file upload result'


  $('#fileupload').fileupload()

  $.getJSON $('#fileupload').prop('action'), (files) ->

    fu = $('#fileupload').data('blueimpFileupload')
    fu._adjustMaxNumberOfFiles(-files.length)

    template = fu._renderDownload(files).appendTo($('#fileupload .files'))

    fu._reflow = fu._transition && template.length && template[0].offsetWidth
    template.addClass('in')

    $('#loading').remove()

  $('.gallery').fancybox
    prevEffect: 'none',
    nextEffect: 'none',
    helpers:
      title:
        type: 'outside'
      thumbs:
        width : 50,
        height  : 50
