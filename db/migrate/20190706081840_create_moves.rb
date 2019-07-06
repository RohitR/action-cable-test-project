class CreateMoves < ActiveRecord::Migration[5.2]
  def change
    create_table :moves do |t|
      t.references :player, foreign_key: true
      t.references :game, foreign_key: true
      t.string :column

      t.timestamps
    end
  end
end
