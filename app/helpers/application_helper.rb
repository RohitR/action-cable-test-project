module ApplicationHelper
  def last_moved_player(game_id)
    Move.where(game_id: game_id).order("id desc").first.player_id
  end
end
