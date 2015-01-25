Handlebars.registerHelper 'avatar', (email, size, title)->
  gravatarUrl = "http://www.gravatar.com/avatar/#{MD5(email.toLowerCase().trim())}?r=g&d=retro&s=#{size * 2}"
  if title
    "<img src=\"#{gravatarUrl}\" class=\"avatar\" width=\"#{size}\" height=\"#{size}\" rel=\"tooltip\" title=\"#{title}\" />"
  else
    "<img src=\"#{gravatarUrl}\" class=\"avatar\" width=\"#{size}\" height=\"#{size}\" />"

Handlebars.registerHelper 'timeago', (date)->
  date = new Date(date) unless _.isDate(date)
  $.timeago(date)
