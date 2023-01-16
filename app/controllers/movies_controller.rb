# Debug tricks:
#  - http://localhost:3000/rails/info/routes
#  - rails routes -c MoviesController
#  - Call 'fail' in a method to see the params, etc
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
    @movie = Movie.find(params[:id])
    @movie.update(movie_params)
    redirect_to @movie
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.save
    redirect_to @movie
  end

  private

  def movie_params
    # Alternative:
    # params.require(:movie).permit!
    #  While convenient, using `permit!` is risky because all the attributes will always be updatable from form data.
    #  Instead, it's better to explicitly list the attributes that can be updated from a form.
    params.require(:movie).
      permit(:title, :description, :rating, :released_on, :total_gross)
  end
end
