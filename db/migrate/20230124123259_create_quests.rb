class CreateQuests < ActiveRecord::Migration[7.0]
  def change
    create_table :quests do |t|
      t.string :name, null: false
      t.string :description
      t.boolean :is_main
      t.integer :next
      t.json :goals

      t.timestamps
    end
  end
end
