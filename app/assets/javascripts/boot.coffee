@Query =
  
  run: ->
    window.router = new Router(reports: window.reports)
    Backbone.history.start(pushState: true)
    
    $('#app').on 'click', 'a', (e)->
      $a = $(e.target)
      href = $a.attr('href')
      if href and !$a.hasClass('download')
        e.preventDefault()
        window.router.navigate href, trigger: true
