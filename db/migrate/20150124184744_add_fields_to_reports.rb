class AddFieldsToReports < ActiveRecord::Migration
  def up
    Report.delete_all
    
    add_column :reports, :user_id, :integer, null: false
    add_column :reports, :columns, :json
    add_column :reports, :performed_at, :timestamp
    add_column :reports, :query_time, :integer
    
    add_column :reports, :updated_at, :timestamp
    add_column :reports, :created_at, :timestamp
  end
  
  def down
    remove_column :reports, :user_id, :integer, null: false
    remove_column :reports, :columns, :json
    remove_column :reports, :performed_at, :timestamp
    remove_column :reports, :query_time, :integer

    remove_column :reports, :updated_at, :timestamp
    remove_column :reports, :created_at, :timestamp
  end
end
