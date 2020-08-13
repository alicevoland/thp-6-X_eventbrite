Rails.application.routes.draw do
  # DEVISE (User)
  devise_for :users

  # ROOT
  root 'events#index'

  # RESOURCES
  resources :events do
    resources :attendances
    resources :pictures, only: %i[new create]
  end

  resources :users, only: %i[show]

  # PROFILE
  get 'profile', to: 'users#profile'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
