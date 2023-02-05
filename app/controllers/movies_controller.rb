# Debug tricks:
#  - http://localhost:3000/rails/info/routes
#  - rails routes -c MoviesController
#  - Call 'fail' in a method to see the params, etc
class MoviesController < ApplicationController

  # NOTE: These controller methods are referred to as Actions in Rail parlance.
  #  And the ones in this controller are all of the standard ones defined when
  #  you add a 'resources' route.
  def index
    @movies = Movie.released
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  # TODO: How do we handle these error scenarios?
  #  - Trying to edit a movie that does exist
  #  - Trying to delete a movie that doesn't exist (it was deleted by someone else and the data is stale)
  #  - Adding a duplicate movie

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to @movie
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie
    else
      # We render the new template with the same data already POSTed
      # If we were to redirect to 'new', we'd lose the previously entered
      # data.
      render :new, status: :unprocessable_entity
    end
  end

  # NOTE: 'destroy' is the internal Rails term, whereas 'delete' is the external term (e.g., HTTP METHOD, SQL, etc)
  def destroy
    # NOTE: There's no reason to set this to an instance variable since the destroy action never shows it
    #  but for consistency with the other actions...
    @movie = Movie.find(params[:id])
    @movie.destroy
    # QUESTION: Why do we need to (re)set the status for a DELETE, but not for a POST, PUT, PATCH above?
    #
    # ANSWER (from the course):
    #  And because the "Delete" link changed the HTTP verb from a GET to a DELETE, you'll need to set the
    #  redirection status to :see_other which is an alias for a 303 HTTP status code. Doing that ensures
    #  the redirect will be followed using a GET request, rather than a DELETE request.
    #
    # TO RECAPITULATE: Since we are using the /movies/:id route and updating the default GET to DELETE,
    #  we need to change it back to GET when we redirect to the same path
    redirect_to movies_url, status: :see_other
  end

  private

    def movie_params
      # ALTERNATIVE:
      # params.require(:movie).permit!
      #  While convenient, using `permit!` is risky because all the attributes will always be updatable from form data.
      #  Instead, it's better to explicitly list the attributes that can be updated from a form.
      params.require(:movie).
        permit(:title, :description, :rating, :released_on, :total_gross,
               :director, :duration, :image_file_name)
    end
end
