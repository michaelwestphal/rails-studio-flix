class ReviewsController < ApplicationController
  # Can append "only: [:action_method_name]" or "except: [:action_method_name]"
  before_action :set_movie

  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(review_params)
    # A REALLY long form version that appear to work. (In need to get better with Ruby hashes and symbols!!)
    # @review = @movie.reviews.new({ name: params[:review][:name], stars: params[:review][:stars], comment: params[:review][:comment] })

    if @review.save
      redirect_to movie_review_path(@movie), notice: "Thanks for your review!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:name, :stars, :comment)
  end
end
