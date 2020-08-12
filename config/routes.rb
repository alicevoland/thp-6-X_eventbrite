Rails.application.routes.draw do
  devise_for :users
  # ROOT
  root 'events#index'

  # RESOURCES
  resources :events

  resources :users, only: %i[show]

  # PROFILE
  get 'profile', to: 'users#profile'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end