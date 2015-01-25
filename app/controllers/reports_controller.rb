class ReportsController < ApplicationController
  attr_reader :report
  before_filter :find_report, only: [:results, :update]
  before_filter :authenticate_user!, except: [:index]
  
  def index
    return render template: "sign_in", layout: "logged_out" unless current_user
    @reports = Report.all
  end
  
  def create
    report = Report.new(report_params)
    report.user = current_user
    
    authorize! :create, report
    
    if report.save
      render json: ReportPresenter.new(report)
    else
      render json: {error: {type: 'validation', messages: report.errors}}, status: :unprocessable_entity
    end
  end
  
  def update
    authorize! :update, report
    
    report.assign_attributes report_params
    if report.save
      render json: ReportPresenter.new(report)
    else
      render json: {error: {type: 'validation', messages: report.errors}}, status: :unprocessable_entity
    end
  end
  
  def destroy
    report = Report.find_by_id params[:id]
    
    if report
      authorize! :destroy, report
      report.destroy 
    end
    
    render json: {}
  end
  
  def results
    authorize! :read, report
    render json: report.perform!
  end
  
private
  
  def report_params
    params.require(:report).permit(:name, :query)
  end
  
  def find_report
    @report = Report.find params[:id]
  end
  
end
