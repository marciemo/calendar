class CreateNotesTable < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :entry
      t.references :notable, :polymorphic => true
      t.timestamps
    end
  end
end
