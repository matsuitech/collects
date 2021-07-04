Rails.application.routes.draw do
    root to: 'toppages#index'
    
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    get 'signup', to: 'users#new'
    resources :users, except: [:new] do
        member do
            get :followings
            get :followers
        end
    end
    
    get 'myposts', to: 'posts#index'
    resources :posts, except: [:index]
    
    resources :relationships, only: [:create, :destroy]
end
