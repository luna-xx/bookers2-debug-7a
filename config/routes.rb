Rails.application.routes.draw do

  get 'relationships/followings'
  get 'relationships/followers'
  devise_for :users
  root to: "homes#top"
  get 'home/about', to: 'homes#about', as: 'about'

  resources :books, only: [:create, :index, :show, :destroy, :edit, :update] do
    resource :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    delete '/book_favorites', to: 'favorites#destroy', as: 'book_favorite'
  end

  resources :users, only: [:index,:show,:edit,:update]

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings', to: 'relationships#followings', as: 'followings'
    get 'followers', to: 'relationships#followers', as: 'followers'
  end

  get "/search", to: "searches#search"
  
  scope module: :public do
    resources :book_comments, only: [:create, :destroy, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 end

