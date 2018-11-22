$ ->
  timeout = setTimeout =>
    $('.notice, .alert').slideUp()
  , 5000

  $('.notice, .alert').on 'click', ->
    clearTimeout timeout
    $(this).slideUp()