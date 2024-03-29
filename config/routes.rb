Bloccit::Application.routes.draw do

  get "posts/index"
  get "comments/create"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  
  resources :users, only: [:show, :index]

  resources :posts, only: [:index]

  resources :topics do 
    resources :posts, except: [:index], controller: 'topics/posts' do
      resources :comments, only: [:create, :destroy]
      resources :playlists, only: [:new, :create, :edit, :update, :destroy]
      match '/up-vote', to: 'votes#up_vote', as: :up_vote, via: :get
      match '/down-vote', to: 'votes#down_vote', as: :down_vote, via: :get
      resources :favorites, only: [:create, :destroy]
    end
  end
  
  match "about" => 'welcome#about', via: :get
  root to: 'welcome#index'
end
