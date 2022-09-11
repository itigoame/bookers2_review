Rails.application.routes.draw do


  devise_for :users
  root to: "homes#top"
  get 'home/about' => "homes#about"
  get "search" => "searches#search"
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :followers,:followings
    end
    resource :relationships,only:[:create, :destroy]
  end
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :rooms, only:[:create, :show]
  resources :comments, only:[:create]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
