Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'movies#index'

  resources :movies do
    resources :reviews
  end

  resources :users

  # Which way?
  # get 'signup', to: 'users#new'
  get 'signup' => 'users#new'
end
