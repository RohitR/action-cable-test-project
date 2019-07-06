class GamesController < ApplicationController
  before_action :game, only: [:play]

  def start
    if player1? && player2_joined?
      game.update_attributes(status: 'start')
      redirect_to :play, game_id: game
    elsif game.ready?
      message = "Player 1 has to start the match"
    else
      message = "player 2 has to join"
    end
    ActionCable.server.broadcast 'messages',
        message: message
      head :ok
  end

  def host
    new_game = Game.create(player1_id: player.id)
    redirect_to play_games_path(game_id: new_game)
  end

  def join
    game.update_attributes(player2_id: player.id)
    redirect_to play_games_path(game_id: game)
  end

  def play
    @moves = game.moves.uniq
    @move = Move.new
  end

  def host_or_join
    @games = Game.ready_to_join.joins(:player1).select("players.email email, games.id as id").pluck(:email, :id)
  end

  private

  def player
    @player ||= Player.where(email: params[:email]).first_or_create
    session[:player_id] = @player.id
    @player
  end

  def game
    @game ||= Game.find(params[:game_id])
  end

  def player1?
    game.player1_id == params[:player_id]
  end

  def player2_joined?
    game.player2_id.present?
  end

end
