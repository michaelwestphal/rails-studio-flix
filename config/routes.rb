Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "movies#index"

  get "movies" => "movies#index"
  get "movies/:id" => "movies#show", as: "movie"
end
