class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.integer :player1_id
      t.integer :status, default: 0
      t.integer :player2_id

      t.timestamps
    end
  end
end
