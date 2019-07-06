class MovesController < ApplicationController
  def create
    move = Move.new(move_params)
    if last_moved_player(move.game_id) == current_player.id
      ActionCable.server.broadcast 'messages',
        message: 'It is opponent move'
      head :ok
    elsif move.save
      ActionCable.server.broadcast 'moves',
        column: move.column,
        email: current_player.email
      head :ok
      if move.player_won?
        ActionCable.server.broadcast 'messages',
        message: "#{current_player.email} won!!! Game over"
      head :ok
      end
    end
  end

  private
  def move_params
    params.require(:move).permit(:player_id, :column, :game_id)
  end

  def last_moved_player(game_id)
    Move.where(game_id: game_id).order("id desc").first.try(:player_id)
  end
end
