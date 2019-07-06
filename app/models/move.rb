class Move < ApplicationRecord
  belongs_to :player
  belongs_to :game

  def player_won?
    game.won?(player, column)
  end
end
