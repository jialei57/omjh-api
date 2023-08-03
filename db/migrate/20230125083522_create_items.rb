class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :item_type
      t.string :description
      t.integer :price

      t.timestamps
    end
  end
end
