class FavoritesController < ApplicationController
  before_action :set_movie
  before_action :require_signin

  def create
    @movie.favorites.create!(user: current_user)
    # or append to the through association
    # @movie.fans << current_user

    redirect_to @movie
  end

  def destroy
    favorite = current_user.favorites.find(params[:id])
    favorite.destroy

    # You do not need to set the redirection status to :see_other since destroy was
    # triggered by a button rather than a link.
    redirect_to @movie
  end

  private

  def set_movie
    @movie = Movie.find_by!(slug: params[:id])
  end
end
