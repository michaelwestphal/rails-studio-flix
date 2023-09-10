Rails.application.routes.draw do
  resources :genres
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'movies#index'

  get 'movies/filter/:filter' => 'movies#index', as: :filtered_movies
  # Another form:
  # (I'm not sure which I prefer, but I tend towards the "hash rocket" one)
  # get 'movies/filter/:filter', to: 'movies#index', as: :filtered_movies

  resources :movies do
    resources :reviews
    resources :favorites, only: [:create, :destroy]
  end

  # Making it a singular session since there will only ever be one
  # https://api.rubyonrails.org/classes/ActionDispatch/Routing/Mapper/Resources.html#method-i-resource
  # https://guides.rubyonrails.org/routing.html#singular-resources
  # resources :sessions, only: %i[new create destroy]
  resource :session, only: %i[new create destroy]
  get 'signin', to: 'sessions#new'

  resources :users
  get 'signup', to: 'users#new'
end
