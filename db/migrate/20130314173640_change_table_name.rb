class ChangeTableName < ActiveRecord::Migration
  def change
    rename_table :event, :events
  end

end
