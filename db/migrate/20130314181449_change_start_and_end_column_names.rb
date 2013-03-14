class ChangeStartAndEndColumnNames < ActiveRecord::Migration
  def change
    rename_column :events, :start, :start_date
    rename_column :events, :end, :end_date
  end
end
