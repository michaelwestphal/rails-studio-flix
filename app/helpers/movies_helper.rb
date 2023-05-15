module MoviesHelper
  def total_gross(movie)
    if movie.flop?
      "Flop!"
    else
      number_to_currency(movie.total_gross, precision: 0)
    end
  end

  def year_of(movie)
    movie.released_on.year
    # movie.released_on.strftime('%Y')
  end

  def average_review(movie)
    reviews = movie.reviews
    if reviews.empty?
      "No reviews"
    else
      aggregate_stars = reviews.map{ |review| review.stars }.reduce(:+)
      average_stars = aggregate_stars / (reviews.size * 1.0)
      "#{pluralize(average_stars, "star")} (#{pluralize(reviews.size, "review")})"
    end
  end
end
