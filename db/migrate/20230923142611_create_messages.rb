class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.integer :user_id, null: false
      t.string :text, null: false
      t.string :photo, null: true

      t.timestamps
    end
    add_foreign_key :messages, :users
  end
end
