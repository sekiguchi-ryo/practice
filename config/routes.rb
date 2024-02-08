Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, path: 'manage', controllers: { sessions: 'manage/sessions' }

  root "home#index"
  
  get  "manage/index", to: 'manage/hoge#index'

  # Defines the root path route ("/")
  # root "articles#index"
  # root "static_pages#home"
  # get  "static_pages/home"
  # get  "static_pages/help"
end
