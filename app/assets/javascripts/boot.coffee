@Query =
  
  run: ->
    window.router = new Router(reports: window.reports)
    Backbone.history.start(pushState: true)
