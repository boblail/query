class @ShowReportView extends Backbone.View
  template: HandlebarsTemplates["reports/show"]
  
  events:
    'click #save_button': 'save'
    'click #delete_report': 'destroy'
    'click h1.report-name': 'beginEditName'
    'keydown h1.report-name > input': 'keydownName'
  
  initialize: (options)->
    @report = options.report
  
  render: ->
    @$el.html @template
      report: @report.toJSON()
    
    if @report.get('results')
      @renderResults()
    else
      @report.perform => @render()
    
    if @$el.find('#report_query').length
      @activateEditor()
  
  renderResults: ->
    results = @report.get('results')
    
    columns = _.keys(results[0])
    
    html = "<table><thead><tr>"
    for column in columns
      html += "<th>#{column}</th>"
    html += "</tr></thead><tbody>"
    for row in results
      html += "<tr>"
      for column in columns
        html += "<td>#{row[column]}</td>"
      html += "</tr>"
    html + "</tbody></table>"
    
    @$el.find('#results').html(html)
  
  renderError: (jqXhr)->
    @$el.find('#results').html """
      <div class="query-error">
        #{jqXhr.responseText}
      </div>
    """
  
  
  
  activateEditor: ->
    @editor = ace.edit("report_query")
    @editor.setTheme "ace/theme/monokai"
    @editor.setShowPrintMargin false
    @editor.$blockScrolling = Infinity
    @editor.setValue @report.get('query')
    session = @editor.getSession()
    session.setMode "ace/mode/sql"
    session.setTabSize 2
    session.setUseSoftTabs true
    
    @editor.commands.addCommand
      name: "Save"
      bindKey:
        win: "Ctrl-S"
        mac: "Command-S"
      exec: => @save()
      readOnly: false # does not apply in readonly mode
    
    @editor.commands.addCommand
      name: "Run"
      bindKey:
        win: "Ctrl-Enter"
        mac: "Command-Enter"
      exec: => @save()
      readOnly: false # does not apply in readonly mode
  
  
  
  beginEditName: ->
    $h1 = @$el.find('.report-name')
    $input = $h1.html('<input id="report_name" type="text" />').find('input')
    $input.val(@report.get('name')).focus().select()
  
  keydownName: (e)->
    switch e.keyCode
      when 27 then @cancelEditName()
      when 13 then @commitEditName()
  
  cancelEditName: ->
    @endEditName()
    
  commitEditName: ->
    @report.save
        name: @$el.find('#report_name').val()
      , success: (=> @endEditName())
      , error: (report, jqXhr)=>
          console.log 'error', jqXhr
  
  endEditName: ->
    $h1 = @$el.find('.report-name')
    $h1.html(@report.get('name'))
  
  
  save: (e)->
    e.preventDefault() if e
    
    @report.save
        name: @$el.find('#report_name').val()
        query: @editor.getValue()
        results: null
      , success: (=> @renderResults())
      , error: (report, jqXhr)=> @renderError(jqXhr)
  
  destroy: (e)->
    e.preventDefault() if e
    @report.destroy
      wait: true
      success: =>
        window.reports.remove(@report)
        window.router.navigate "/", trigger: true
      error: ->
        console.log 'error', arguments
