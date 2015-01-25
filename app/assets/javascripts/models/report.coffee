class @Report extends Backbone.Model
  urlRoot: "/api/v1/reports"
  
  perform: (callback)->
    $.getJSON "#{@url()}/results", (results)=>
      @set "results", results
      callback()
  
  copy: (newAttributes)->
    newAttributes.query = @get('query')
    newAttributes.name = @get('name')
    console.log newAttributes
    new Report(newAttributes)

class @Reports extends Backbone.Collection
  model: Report
