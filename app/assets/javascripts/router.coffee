class @Router extends Backbone.Router
  
  routes:
    "": "listReports"
    "reports/new": "newReport"
    "reports/:id": "showReport"
  
  initialize: (options)->
    @reports = options.reports
  
  listReports: ->
    view = new ReportsView
      el: document.getElementById("app")
      reports: window.reports
    view.render()
  
  showReport: (id)->
    report = @reports.get(id)
    if report
      view = new ShowReportView
        el: document.getElementById("app")
        report: report
      view.render()
    else
      $('#app').html HandlebarsTemplates['404']()
  
  newReport: ->
    view = new NewReportView
      el: document.getElementById("app")
    view.render()
