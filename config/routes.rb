Rails.application.routes.draw do
  devise_for :users
  root "books#top"

  resources :users, only: [:index, :show, :edit, :new, :update]

  resources :books, only: [:create, :destroy, :index, :edit, :show, :update]
 

  # post "/users/:id" => "books#create"
  get "/home/about" => "books#about"

end
