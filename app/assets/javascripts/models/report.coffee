class @Report extends Backbone.Model
  urlRoot: "/api/v1/reports"
  
  perform: (callback)->
    $.getJSON "#{@url()}/results", (results)=>
      @set "results", results
      callback()
  
class @Reports extends Backbone.Collection
  model: Report
