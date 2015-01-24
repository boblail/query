class AddResultsToReports < ActiveRecord::Migration
  def change
    add_column :reports, :results, :jsonb
  end
end
