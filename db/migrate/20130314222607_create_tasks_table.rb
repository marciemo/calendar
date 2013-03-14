class CreateTasksTable < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.column :name, :string
      
      t.timestamps
    end

  end

end
