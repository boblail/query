class @Report extends Backbone.Model
  urlRoot: "/api/v1/reports"
  
  perform: (callback)->
    $.getJSON "#{@url()}/results", (resp)=>
      if @set @parse(resp)
        @trigger 'sync', @, resp
        callback()
  
  copy: (newAttributes)->
    newAttributes.query = @get('query')
    newAttributes.name = @get('name')
    new Report(newAttributes)

class @Reports extends Backbone.Collection
  model: Report
