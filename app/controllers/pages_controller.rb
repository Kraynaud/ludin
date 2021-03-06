class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :uikit]

  def home
  end

  def uikit
  end

  def profil
    @user = User.find(params[:user_id])
    # @global_rating = @user.global_rating
    @user_boardgames = @user.boardgames
    @user_full_gamenights = @user_boardgames.map { |boardgame| boardgame.gamenights }
    @user_futur_gamenights = owner_gamenights_profil
  end

  def dashboard
    @user = current_user
    @my_boardgames = current_user.boardgames
    @my_locations = current_user.locations
    @my_participations = current_user.participations
    @gamenights_owner = owner_gamenights_dahsboard
  end

  private

  def owner_gamenights_dahsboard
    gamenights = []
    @my_boardgames.each do |boardgame|
      boardgame.gamenights.each do |gamenight|
        gamenights << gamenight
      end
    end
    return gamenights
  end

  def owner_gamenights_profil
    gamenights = []
    @user_boardgames.each do |boardgame|
      boardgame.gamenights.each do |gamenight|
        gamenights << gamenight if gamenight.date >= Time.now.to_date
      end
    end
    return gamenights
  end
end
