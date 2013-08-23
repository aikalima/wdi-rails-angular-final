class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :name
      t.boolean :winner
      t.integer :rating
      t.timestamps
    end
  end
end
