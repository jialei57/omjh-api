class CreateNpcs < ActiveRecord::Migration[7.0]
  def change
    create_table :npcs do |t|
      t.string :name, null: false
      t.integer :map
      t.json :status
      t.json :info

      t.timestamps
    end
  end
end
