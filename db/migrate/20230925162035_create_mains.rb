class CreateMains < ActiveRecord::Migration[7.0]
  def change
    create_table :mains do |t|
      t.text :message, null: true
      t.timestamps
    end
  end
end
