class Game < ApplicationRecord
  belongs_to :player1, class_name: "Player"
  belongs_to :player2, class_name: "Player", optional: true

  has_many :moves

  scope :ready_to_join, ->{where(status: 'ready')}

  enum status: [:ready, :start, :end]

  def won?(player, column)
    column = column.to_i
    marked_columns = moves.where(player: player).pluck(:column).map(&:to_i)
    rem = column%board_dimension
    rem = board_dimension if rem == 0
    backward = rem - 1

    forward = board_dimension - rem

    status = true 
    unless backward == 0
      backward.times  do |ind|
        ind = ind + 1

        status &= marked_columns.include? (column-(ind))
      end
    end

    unless forward == 0
      forward.times  do |incre|
        incre = incre + 1

        status &= marked_columns.include? (column+(incre))
      end
    end
    return status
  end

  def board_dimension
    3
  end



end
