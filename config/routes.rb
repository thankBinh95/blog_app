Rails.application.routes.draw do

  get "sessions/new"
  get "entries/new"
  post "/entry", to: "entries#create"
  get "/entry", to: "entries#new"
  get "password_resets/new"
  get "password_resets/edit"
  get "sessions/new"
  get "users/new"
  get "users/index"
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :entries, only: %i(create destroy)

end
