# Debug tricks:
#  - http://localhost:3000/rails/info/routes
#  - rails routes -c MoviesController
#  - Call 'fail' in a method to see the params, etc
class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy]
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  # NOTE: These controller methods are referred to as Actions in Rail parlance.
  #  And the ones in this controller are all of the standard ones defined when
  #  you add a 'resources' route.
  def index
    @movies = Movie.send(movies_filter)
  end

  def show
    # RE-ENABLE once the nested review form is back on the show movie page
    # @review = @movie.reviews.new
    @fans = @movie.fans
    @genres = @movie.genres.order(:name)

    @favorite = current_user.favorites.find_by(movie_id: @movie.id) if current_user
    # OR:
    # @favorite = @movie.fans.find_by(id: current_user.id)
    # NOTE: Using .find throws an ActiveRecord::RecordNotFound exception if missing
  end

  def edit; end

  # TODO: How do we handle these error scenarios?
  #  - Trying to edit a movie that does exist
  #  - Trying to delete a movie that doesn't exist (it was deleted by someone else and the data is stale)
  #  - Adding a duplicate movie

  def update
    if @movie.update(movie_params)
      # flash[:notice] = "Movie successfully updated!"
      # OR inline with the redirect:
      redirect_to @movie, notice: 'Movie successfully updated!'
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
      # Rails redirect_to supports :notice and :alert flash types by default
      # https://api.rubyonrails.org/classes/ActionController/Redirecting.html#method-i-redirect_to
      # Also: https://guides.rubyonrails.org/action_controller_overview.html#the-flash
      redirect_to @movie, notice: 'Movie successfully created!'
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
    redirect_to movies_url, status: :see_other, alert: 'Movie successfully deleted!'
    # TO SHOW CUSTOM FLASH TYPES:
    # - Comment out the body of this method and uncomment the redirect below
    # - See the add_flash_types(:danger) within ApplicationController
    # redirect_to movies_url, status: :see_other,
    #             danger: "I'm sorry, Dave, I'm afraid I can't do that!"
  end

  private

  def set_movie
    @movie = Movie.find_by!(slug: params[:id])
  end

  def movie_params
    # ALTERNATIVE:
    # params.require(:movie).permit!
    #  While convenient, using `permit!` is risky because all the attributes will always be updatable from form data.
    #  Instead, it's better to explicitly list the attributes that can be updated from a form.
    params.require(:movie)
          .permit(:title, :description, :rating, :released_on, :total_gross,
                  :director, :duration, :main_image, genre_ids: [])
  end

  def movies_filter
    if params[:filter].in? %w[upcoming recent hits flops]
      params[:filter]
    else
      :released
    end
  end
end
