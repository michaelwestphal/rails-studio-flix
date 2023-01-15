require "test_helper"

class MovieTest < ActiveSupport::TestCase
  test "is a flop when total gross is blank" do
    movie = Movie.new
    assert movie.flop?
  end

  test "is a flop when total gross isn't high enough" do
    movie = Movie.new(total_gross: 224_999_999.99)
    assert movie.flop?
  end

  test "is not a flop when total gross is high enough" do
    movie = Movie.new(total_gross: 225_000_000)
    assert_not movie.flop?
  end
end
