Rails.application.routes.draw do
  root to: "main#index"

  get "password", to: "passwords#edit", as: :edit_password
  patch "password", to: "passwords#update"

  get "password/reset",to: "password_resets#new"
  post "password/reset",to: "password_resets#create"
  
  get "password/reset/edit",to: "password_resets#edit"
  patch "password/reset/edit",to: "password_resets#update"

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  delete "sign_out", to: "sessions#destroy"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  get "about", to: "about#index"

  get "auth/twitter/callback", to: "omniauth_callbacks#twitter"

  resources :twitter_accounts
  resources :users, only: [:index]
end
