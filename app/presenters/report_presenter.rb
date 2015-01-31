class ReportPresenter
  attr_reader :report
  
  def initialize(report)
    @report = report
  end
  
  def to_json(options={})
    MultiJson.dump(as_json(options))
  end
  
  def as_json(options={})
    if @report.respond_to?(:each)
      @report.map(&method(:report_as_json))
    else
      report_as_json @report
    end
  end
  
  def report_as_json(report)
    { id: report.id,
      author: {
        id: report.user.id,
        name: report.user.name,
        email: report.user.email },
      
      name: report.name,
      query: report.query,
      created: report.created_at,
      updated: report.updated_at,
      performed: report.performed_at,
      
      columns: report.columns,
      results: report.results,
      queryTime: report.query_time }
  end
  
end
