class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.integer :game_id
      t.boolean :victory
      t.boolean :turn

      t.timestamps
    end
    add_index :users, :game_id
  end
end
