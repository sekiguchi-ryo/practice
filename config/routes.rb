Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # devise_for :users, path: 'manage', controllers: { sessions: 'manage/sessions'}
  devise_for :users, path: 'manage', controllers: { sessions: 'manage/sessions',
                                                    registrations: 'manage/registrations'}

  root "home#index"
  namespace :manage do
    resources :hoge, only: [:index]
    resources :users do
      collection { post :import }
    end
    # resources :setting
    get  "setting/index", to: 'setting#index'
    patch "setting/edit", to: "setting#edit"
    resources :pdfs
  end

  namespace :api do
    resources :users, only: [:show]
    post "login", to: "authentication#login"
  end

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
