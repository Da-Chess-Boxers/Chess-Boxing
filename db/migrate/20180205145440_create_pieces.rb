class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.string :type
      t.integer :game_id
      t.string :color
      t.string :position_x
      t.string :position_y
      t.boolean :captured

      t.timestamps
    end
    add_index :pieces, :game_id
  end
end
