class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :sex, null: false
      t.json :status
      t.integer :map, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
