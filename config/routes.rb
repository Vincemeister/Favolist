Rails.application.routes.draw do
  devise_for :users
  root to: "products#index"
  resources :users, only: [:index, :show] do
    member do
      post :follow
      post :unfollow
      post :remove_follower
    end

    get :follows, on: :member
  end

  resources :lists, only: [:show]
  resources :products, only: [:index, :show]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
