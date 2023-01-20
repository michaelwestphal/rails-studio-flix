class Movie < ApplicationRecord
  # NOTE: Class level method
  def self.released
    # NOTE: The placeholder, '?', is needed to convert the Ruby type into a valid
    #  SQL type. Otherwise we would need to convert it ourselves if we wanted to
    #  use String interpolation. (There's also a question of properly sanitized inputs
    #  if we use interpolation. I'm guessing we're responsible for this if we chose that
    #  means.)
    where("released_on < ?", Time.now).order(released_on: :desc)
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
    total_gross.blank? || total_gross < 225_000_000
  end
end
