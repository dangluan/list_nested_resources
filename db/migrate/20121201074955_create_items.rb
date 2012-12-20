class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :todolist_id
      t.integer :position
      t.boolean :done , :default => false

      t.timestamps
    end
  end
end
