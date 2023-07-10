Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'movies#index'

  resources :movies do
    resources :reviews
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
