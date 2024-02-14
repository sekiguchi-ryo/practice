Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # devise_for :users, path: 'manage', controllers: { sessions: 'manage/sessions'}
  devise_for :users, path: 'manage', controllers: { sessions: 'manage/sessions',
                                                    registrations: 'manage/registrations'}

  root "home#index"
  namespace :manage do
    resources :hoge, only: [:index]
    resources :users
    # resources :setting
    # get "index", to: "hoge#index"
    get  "setting/index", to: 'setting#index'
    patch "setting/edit", to: "setting#edit"
  end
  # get  "manage/index", to: "manage/hoge#index"
  # get  "manage/setting/index", to: 'manage/setting#index'
  # patch "manage/setting/edit", to: "manage/setting#edit"

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
