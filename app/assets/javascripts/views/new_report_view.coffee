class @NewReportView extends @ShowReportView
  template: HandlebarsTemplates["reports/new"]
  
  initialize: (options)->
    @reports = window.reports
    super
    @readonly = false

  render: ->
    super
    @$el.find('#report_name')
      .val(@report.get('name'))
      .focus()
      .select()

  save: (e)->
    e.preventDefault() if e
    
    report = @reports.create
        name: @$el.find('#report_name').val()
        query: @editor.getValue()
      , wait: true
      , success: (report)=>
        window.router.navigate "/reports/#{report.id}", trigger: true
      , error: (report, jqXhr)=> @renderError(jqXhr)
