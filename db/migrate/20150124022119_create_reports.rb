class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :name, null: false
      t.text :query, null: false
    end
  end
end
