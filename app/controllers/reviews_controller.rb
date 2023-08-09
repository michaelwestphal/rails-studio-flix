class ReviewsController < ApplicationController
  # Can append "only: [:action_method_name]" or "except: [:action_method_name]"
  before_action :require_signin
  before_action :set_movie
  before_action :set_review, only: [:edit, :update, :destroy]

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
    @review.user = current_user

    if @review.save
      redirect_to movie_reviews_url, notice: "Thanks for your review!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to movie_reviews_url, notice: "Review successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to movie_reviews_url, status: :see_other, alert: "Review successfully deleted!"
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_review
    @review = @movie.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:stars, :comment)
  end
end
