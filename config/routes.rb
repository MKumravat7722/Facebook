Rails.application.routes.draw do
  # root "user#index"
  # get 'users/:id',to: "user#show"
  resources :users, only: [ :index, :show, :create, :update]
  #  get 'user/:id/posts', to: 'user#posts'
  #  get 'user/:id/likes', to: 'user#likes'
  #  get 'user/:id/followers',to:'user#followers'
  #  get 'user/:id/following',to: 'user#followings'
  resources :posts, only: [ :show, :create]
    get 'users/:id/posts', to: 'users#user_post'
    # get 'user/:id/posts', to: 'post#user_post'
    get 'posts/users/:id',to: 'posts#user_post_by_user'
  # resources :likes, only:[:index,:create]
  resources :posts do
    resources :likes ,only: [:create,:destroy,:show]
  end
  resources :users do
  resources :notifications, only: [:index]
  end
  resources :users do
    resources :posts, only:[:create,:update,:show,:destroy]
  end
  resources :posts do
    resources :comments ,only:[:index,:create]
  end
  get 'comments/:id', to: "comments#show"
  post 'auth/login', to: 'authentication#login'
  end