class Movie < ApplicationRecord
  RATINGS = %w[G PG PG-13 R NC-17]

  has_many :reviews, dependent: :destroy

  # TODO: For TDD I could have written a test where I expect these
  #  to be in place and assert the error message exists and then the
  #  valid case.
  validates :title, :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: 'must be a JPG or PNG image'
  }
  validates :rating, inclusion: RATINGS
  #  OR
  # validates :rating, inclusion: { in: RATINGS }

  # NOTE: Class level method
  def self.released
    # NOTE: The placeholder, '?', is needed to convert the Ruby type into a valid
    #  SQL type. Otherwise we would need to convert it ourselves if we wanted to
    #  use String interpolation. (There's also a question of properly sanitized inputs
    #  if we use interpolation. I'm guessing we're responsible for this if we chose that
    #  means.)
    where('released_on < ?', Time.now).order(released_on: :desc)
    # OR
    # where("released_on < ?", Time.now).order("released_on desc")

    # EXAMPLES from the course of some predicates:
    #
    # Movie.where("total_gross < 225000000")
    # Movie.where("total_gross < ?", 225_000_000)
    # Movie.where(rating: "PG-13")
    # Movie.where("rating = 'PG-13'")
    # Movie.where(total_gross: 250_000_000..900_000_000)
    # Movie.where(total_gross: 250_000_000..)
    # Movie.where(total_gross: ..900_000_000)
  end

  def flop?
    # My horribly non-Rubyesc solution:
    # (total_gross.blank? || total_gross < 225_000_000) && !(reviews.count >= 50 && reviews.average(:stars) >= 4)

    # Original used an 'unless' statement here
    return if reviews.count > 50 && average_stars >= 4

    (total_gross.blank? || total_gross < 225_000_000)
  end

  def average_stars
    # Originally I performed the average manually like this before I learned about the ActiveRecord::Calculations
    # module:
    #
    # aggregate_stars = reviews.map{ |review| review.stars }.reduce(:+)
    # aggregate_stars / (reviews.size * 1.0)

    reviews.average(:stars) || 0.0
  end

  def average_stars_as_percent
    (average_stars / 5.0) * 100
  end
end
