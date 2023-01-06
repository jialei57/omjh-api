class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :content, null: false
      t.string :char_name, null: false
      t.integer :map, null: false

      t.timestamps
    end
  end
end
