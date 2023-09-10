module MoviesHelper
  def total_gross(movie)
    if movie.unreleased?
      'Unreleased'
    elsif movie.flop?
      'Flop!'
    else
      number_to_currency(movie.total_gross, precision: 0)
    end
  end

  def year_of(movie)
    movie.released_on.year
    # movie.released_on.strftime('%Y')
  end
  
  # Why here and not higher in the application helper? Other than it is movie specific
  def nav_link_to(name, url)
    if current_page?(url)
      link_to(name, url, class: 'active')
    else
      link_to(name, url)
    end
  end
end
