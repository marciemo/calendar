class CalendarAndEventsTableCreation < ActiveRecord::Migration
  def change
    create_table :event do |t|
      t.column :name, :string
      t.column :location, :string
      t.column :start, :datetime
      t.column :end, :datetime
      

      t.timestamps
    end
  end
end
