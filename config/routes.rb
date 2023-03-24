Rails.application.routes.draw do
  get 'landing_page/tetris'
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

  resources :products, only: [:index, :show, :new, :create] do
    member do
      post :bookmark
      post :unbookmark
    end

    member do
      get :comments
    end

    resources :comments, only: [:create] do
      member do
        get :replies, as: :comment_replies
      end
    end




  end


  resources :lists, only: [:show, :new, :create]


  get 'welcome', to: 'welcome#show'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
