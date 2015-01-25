@Query =
  
  run: ->
    window.router = new Router(reports: window.reports)
    Backbone.history.start(pushState: true)
    
    $('#app').on 'click', 'a', (e)->
      href = $(e.target).attr('href')
      if href
        e.preventDefault()
        window.router.navigate href, trigger: true
