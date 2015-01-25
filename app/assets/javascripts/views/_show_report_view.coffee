class @ShowReportView extends Backbone.View
  template: HandlebarsTemplates["reports/show"]
  
  events:
    'click #save_button': 'save'
    'click #delete_report': 'destroy'
    'click .report-name.inline-edit': 'beginEditName'
    'keydown .report-name.inline-edit > input': 'keydownName'
    'blur .report-name.inline-edit > input': 'cancelEditName'
  
  initialize: (options)->
    @report = options.report
    @readonly = @report.get('author').id isnt window.user.id
  
  render: ->
    @$el.html @template
      readonly: @readonly
      report: @report.toJSON()
    
    if @report.get('results')
      @renderResults()
    
    if @$el.find('#report_query').length
      @activateEditor()
  
  renderResults: ->
    results = @report.get('results')
    columns = @report.get('columns')
    
    html = '<table class="table table-striped tablesorter"><thead><tr>'
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
    @$el.find('.tablesorter').tablesorter()
  
  renderError: (jqXhr)->
    error = JSON.parse(jqXhr.responseText).error
    @$el.find('#results').html """
      <div class="error error-#{error.type}">
        #{@formatErrors(error.type, error.messages)}
      </div>
    """
  
  formatErrors: (type, errors)->
    switch type
      when 'validation' then @formatValidationsErrors(errors)
      else
        JSON.stringify errors
  
  formatValidationsErrors: (errors)->
    text = ''
    for key, messages of errors
      for message in messages
        if key == 'query'
          text += '<pre>' + message + '</pre>'
        else
          text += key + ': ' + message
    text
  
  
  
  activateEditor: ->
    @editor = ace.edit("report_query")
    @editor.setTheme "ace/theme/monokai"
    @editor.setShowPrintMargin false
    @editor.$blockScrolling = Infinity
    @editor.setReadOnly @readonly
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
    $h2 = @$el.find('.report-name')
    $input = $h2.html('<input id="report_name" type="text" />').find('input')
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
    $h2 = @$el.find('.report-name')
    $h2.html(@report.get('name'))
  
  
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
