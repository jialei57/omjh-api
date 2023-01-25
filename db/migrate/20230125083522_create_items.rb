class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, null: false, index: { unique: true }
      t.boolean :is_unique
      t.string :item_type
      t.json :info

      t.timestamps
    end
  end
end
