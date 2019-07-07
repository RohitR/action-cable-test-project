class Move < ApplicationRecord
  attr_reader :status
  belongs_to :player
  belongs_to :game

  def won?
    check_row_wise || check_column_wise || check_diagonal_wise
  end


  private

  def all_moves
    @all_moves ||= game.moves.where(player: player).pluck(:column).map(&:to_i)
  end

  def check_row_wise
    @status = true
    traverse_beteween(row_range)
    return status
  end

  def check_column_wise
    @status = true
    traverse_beteween(column_range)

    return status
  end

  def check_diagonal_wise
    marked_diagonal?(diagonal1) || marked_diagonal?(diagonal2)
  end

  def diagonal1
    d1_start = 1
    d1_end = board_dimension ** 2

    generate_column_array(d1_start, d1_end, board_dimension+1)
  end

  def diagonal2
    d2_start = board_dimension
    d2_end = (board_dimension ** 2) - (board_dimension-1)
    generate_column_array(d2_start, d2_end, board_dimension-1)
  end

  def marked_diagonal?(diagonal_elements)
    if diagonal_elements.include? column
      @status = true
      traverse_beteween(diagonal_elements)
    else
      @status = false
    end

  end

  def board_dimension
    Game::BOARD_DIMENSION
  end

  def row_range
    rem = column%board_dimension
    div = column / board_dimension
    start_row = rem.zero? ? ((div-1)*board_dimension)+1 : (div*board_dimension)+1
    end_row = rem.zero? ? (div * board_dimension) : (div+1) * board_dimension
    (start_row..end_row)
  end

  def column_range
    div = column / board_dimension
    rem = column % board_dimension
    start = rem.zero? ? board_dimension : rem
    end_row = rem.zero? ? board_dimension * board_dimension : ((board_dimension**2)-(board_dimension-rem))
    
    generate_column_array(start, end_row, board_dimension)
  end

  def generate_column_array(start, end_point, diff)
    res = []
    while end_point >= start
      res << start
      start += diff
    end
    res
  end

  def traverse_beteween(range)
    @status = range.inject(status){|res, column| res &= all_moves.include? column}
  end
end
