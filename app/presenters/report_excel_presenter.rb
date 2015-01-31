class ReportExcelPresenter
  attr_reader :report
  
  def initialize(report)
    @report = report
  end
  
  def to_s
    package = Xlsx::Package.new
    worksheet = package.workbook.worksheets[0]
    
    worksheet.add_row(
      number: 1,
      cells: report.columns.each_with_index.map { |column, i|
        { column: i + 1, value: column } })
    
    report.results.each_with_index do |row, i|
      worksheet.add_row(
        number: i + 2,
        cells: report.columns.each_with_index.map { |column, i|
          { column: i + 1, value: row[column] } })
    end
    
    package.to_stream.string
  end

end
