Rails.application.routes.draw do
    root to: 'toppages#index'
    get 'operator', to: 'toppages#operator'
    
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    get 'signup', to: 'users#new'
    resources :users, except: [:new] do
        member do
            get :followings
            get :followers
            get :posts
        end
        collection do
            get :allhashtags
            get :edit
        end
    end
    
    get 'myposts', to: 'posts#index'
    resources :posts, except: [:index]
    
    resources :relationships, only: [:create, :destroy]
    
    get '/hashtags/:name/posts', to: "posts#hashtag", as: 'hashtags'
    get '/hashtags/:name/myposts', to: "posts#myhashtag", as: 'myhashtags'
    
    
end
