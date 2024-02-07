Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "static_pages#home"
  get  "static_pages/home"
  get  "static_pages/help"
  # get  "/signup", to: "users#new"
  # resources :users
  devise_for :users
end
