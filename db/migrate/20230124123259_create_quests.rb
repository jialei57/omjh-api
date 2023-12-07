class CreateQuests < ActiveRecord::Migration[7.0]
  def change
    create_table :quests do |t|
      t.string :name, null: false
      t.string :description
      t.string :quest_type
      t.integer :level_required
      t.integer :start_npc
      t.integer :end_npc
      t.string :start_line
      t.string :mid_line
      t.string :end_line
      t.json :goals
      t.json :rewards

      t.timestamps
    end
  end
end
