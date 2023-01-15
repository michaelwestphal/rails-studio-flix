class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    # Use "fail" trick to view what is coming through via the Rails error page
    # fail
    @movie = Movie.find(params[:id])
    movie_params =
      params.require(:movie).
        permit(:title, :description, :rating, :released_on, :total_gross)
    # Alternative:
    # params.require(:movie).permit!
    #  While convenient, using `permit!` is risky because all the attributes will always be updatable from form data.
    #  Instead, it's better to explicitly list the attributes that can be updated from a form.
    @movie.update(movie_params)
    redirect_to @movie
  end
end
