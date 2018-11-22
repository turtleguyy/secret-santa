$ ->
  # $(#new_member).input!=blankspace

  # form = $('#new_member')

  # if form.input.value() == ''
  #   return null

  $('form').on 'submit', ->
    valid = true
    $inputs = $(this).find('.required input')
    $inputs.each (index, input) ->
      valid = false if valid and input.value == ""

    return valid