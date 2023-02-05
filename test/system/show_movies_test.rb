require "application_system_test_case"

class ShowMoviesTest < ApplicationSystemTestCase
  test "Showing a movie" do
    @movie = movies(:one)

    visit movies_path

    assert_any_of_selectors "h2", text: @movie.title

    click_link @movie.title

    assert_selector "h1", text: @movie.title
  end
end
