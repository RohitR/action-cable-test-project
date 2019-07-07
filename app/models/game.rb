class Game < ApplicationRecord
  BOARD_DIMENSION = 3
  belongs_to :player1, class_name: "Player"
  belongs_to :player2, class_name: "Player", optional: true

  has_many :moves

  scope :ready_to_join, ->{where(status: 'ready')}

  enum status: [:ready, :start, :end]

end
