Rails.application.routes.draw do
  # ROOT
  root 'static_pages#home'

  # DEVISE (User)
  devise_for :users

  # RESOURCES
  resources :users, only: %i[show]

  resources :events do
    resources :attendances
    resources :pictures, only: %i[new create]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
