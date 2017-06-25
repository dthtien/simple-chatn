$(document).on 'turbolinks:load', ->
  $searchSesult = $('ul#search-results')
  $('#search_term').on 'keyup', ->
    val = $(this).val()
    if val.length > 3
      $.ajax
        url: '/search'
        data: {'search[term]': $(this).val()}
        success: (data) ->
          items = ''
          if $.isEmptyObject(data)
            items = "<li>User not found</li>"
          else
            $.each data,(k, v) ->
              items += '<li><a data-method="post" href="/conversations?receiver_id='+ v.receiver_id + '&amp;sender_id= '+ v.sender_id + '">' + k + '</a></li>'

          $searchSesult.html(items)

  $('#search_term').on 'blur', ->
    $(this).val("")