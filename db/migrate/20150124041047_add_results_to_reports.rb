class AddResultsToReports < ActiveRecord::Migration
  def change
    add_column :reports, :results, :json
  end
end
