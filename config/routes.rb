Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, path: 'manage', controllers: { sessions: 'manage/sessions' }

  root "home#index"
  
  get  "manage/index", to: 'manage/hoge#index'

  resources :contacts, only: [:new, :create] do
    collection do
      post 'confirm'
      post 'back'
      get 'done'
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
  # root "static_pages#home"
  # get  "static_pages/home"
  # get  "static_pages/help"
end
