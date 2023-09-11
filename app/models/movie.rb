class Movie < ApplicationRecord
  RATINGS = %w[G PG PG-13 R NC-17]

  before_save :set_slug

  has_many :reviews, dependent: :destroy
  # Another Use for Lambdas
  #
  # Now that you have a handle on Ruby lambdas, you might be interested to learn that you can
  # pass a Ruby lambda as the second parameter to the has_many method to customize the query.
  #
  # For example, suppose you wanted to change the ordering of movie reviews so that the
  # most-recent review appeared first in the listing on http://localhost:3000/movies/1/reviews.
  # To do that, change the has_many :reviews declaration in the Movie model like so:
  #
  # has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy

  # TODO: If we truly use this, then I'd look into creating an index too.
  has_many :critics, through: :reviews, source: :user

  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user

  has_many :classifications, dependent: :destroy
  has_many :genres, through: :classifications

  # TODO: For TDD I could have written a test where I expect these
  #  to be in place and assert the error message exists and then the
  #  valid case.
  validates :title, presence: true, uniqueness: true
  validates :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: 'must be a JPG or PNG image'
  }
  validates :rating, inclusion: RATINGS
  #  OR
  # validates :rating, inclusion: { in: RATINGS }

  scope :released, -> { where('released_on < ?', Time.now).order(released_on: :desc) }
  scope :upcoming, -> { where('released_on > ?', Time.now).order(released_on: :asc) }
  scope :recent, ->(max = 5) { released.limit(max) }
  # OR explicitly denote this as a lambda:
  # scope :recent, lambda { |max = 5|  released.limit(max) }
  #
  scope :hits, -> { released.where('total_gross >= 300000000').order(total_gross: :desc) }
  #
  # Note that the flop? method below has extra logic. Would I do this in "real life", I hope not, but I'll leave it for now.
  # TODO: Revisit the lessons where 'hits' and 'flops' were added. (I must have skipped bonus activities)
  scope :flops, -> { released.where('total_gross < 225000000').order(total_gross: :asc) }
  scope :grossed_less_than, ->(amount) { released.where("total_gross < ?", amount) }
  scope :grossed_greater_than, ->(amount) { released.where("total_gross > ?", amount) }

  # NOTE: Class level method
  # def self.released
  #   # NOTE: The placeholder, '?', is needed to convert the Ruby type into a valid
  #   #  SQL type. Otherwise we would need to convert it ourselves if we wanted to
  #   #  use String interpolation. (There's also a question of properly sanitized inputs
  #   #  if we use interpolation. I'm guessing we're responsible for this if we chose that
  #   #  means.)
  #   where('released_on < ?', Time.now).order(released_on: :desc)
  #   # OR
  #   # where("released_on < ?", Time.now).order("released_on desc")
  #
  #   # EXAMPLES from the course of some predicates:
  #   #
  #   # Movie.where("total_gross < 225000000")
  #   # Movie.where("total_gross < ?", 225_000_000)
  #   # Movie.where(rating: "PG-13")
  #   # Movie.where("rating = 'PG-13'")
  #   # Movie.where(total_gross: 250_000_000..900_000_000)
  #   # Movie.where(total_gross: 250_000_000..)
  #   # Movie.where(total_gross: ..900_000_000)
  # end

  def unreleased?
    released_on > Time.now
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

  def to_param
    slug
  end

  private

  def set_slug
    # When assigning to a model attribute need self<dot>, but not when reading.
    self.slug = title.parameterize
  end
end
