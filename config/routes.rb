Bloccit::Application.routes.draw do

  get "posts/index"
  get "comments/create"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  
  resources :users, only: [:show, :index]

  resources :posts, only: [:index]

  resources :topics do 
    resources :posts, except: [:index], controller: 'topics/posts' do
      resources :comments, only: [:create, :destroy]
      resources :playlists, only: [:new, :create, :edit, :update]
      match '/up-vote', to: 'votes#up_vote', as: :up_vote, via: :get
      match '/down-vote', to: 'votes#down_vote', as: :down_vote, via: :get
      resources :favorites, only: [:create, :destroy]
    end
  end
  
  match "about" => 'welcome#about', via: :get

  #added a separate route for soundcloud connection
  #and different screens for connect, connected, and disconnect

  #connect goes to the redirect URI listed in the soundcloud app
  match '/soundcloud/connect',    :to => 'soundcloud#connect',    :as => :soundcloud_connect,    via: :get
  
  #receiving view after the redirect is completed
  match '/soundcloud/connected',  :to => 'soundcloud#connected',  :as => :soundcloud_connected,  via: :get
  match '/soundcloud/disconnect', :to => 'soundcloud#disconnect', :as => :soundcloud_disconnect, via: :get
  
  root to: 'welcome#index'
end
