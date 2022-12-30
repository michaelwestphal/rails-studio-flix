class MoviesController < ApplicationController
  def index
    @movies = %w(Interstellar Tenet Dune Inception)
  end
end
