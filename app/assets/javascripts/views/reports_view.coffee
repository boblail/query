class @ReportsView extends Backbone.View
  
  initialize: (options)->
    @reports = options.reports
    @reports.on "add", _.bind(@render, @)
    @reports.on "remove", _.bind(@render, @)
    @reports.on "sync", _.bind(@render, @)
    @reports.on "change", _.bind(@render, @)
  
  render: ->
    @$el.html HandlebarsTemplates["reports/index"]
      reports: @reports.toJSON()
