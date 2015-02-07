String::commafy = ->
  @replace /(^|[^\w.])(\d{4,})/g, ($0, $1, $2)->
    $1 + $2.replace(/\d(?=(?:\d\d\d)+(?!\d))/g, "$&,")
