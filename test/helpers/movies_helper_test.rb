require "test_helper"

class MoviesHelperTest < ActionView::TestCase
  test "total gross is a flop" do
    movie = Movie.new
    assert_equal total_gross(movie), "Flop!"
  end

  test "total gross is currency" do
    movie = Movie.new(total_gross: 225_000_000)
    assert_equal total_gross(movie), "$225,000,000"
  end

  test "year of movie" do
    movie = Movie.new(released_on: '1984-09-13')
    assert_equal year_of(movie), 1984
  end
end
