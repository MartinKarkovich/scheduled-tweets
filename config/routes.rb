Rails.application.routes.draw do
  root to: "main#index"

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  delete "sign_out", to: "sessions#destroy"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  get "about", to: "about#index"

  resources :users, only: [:index]
end
