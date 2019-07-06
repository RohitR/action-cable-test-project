class ApplicationController < ActionController::Base
  before_action :current_player
  def current_player
    return unless session[:player_id]
    @current_player ||= Player.find(session[:player_id])
  end
end
