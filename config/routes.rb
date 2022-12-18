Rails.application.routes.draw do
  resources :memberships
  resource :membership
  resources :beer_clubs
  resources :users
  resources :beers
  resources :styles
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :places, only: [:index, :show]
  root 'breweries#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'

  post 'places', to: 'places#search'
  post 'memberships', to: 'memberships#create'
  delete 'memberships', to: 'memberships#destroy'

  delete 'signout', to: 'sessions#destroy'
end
