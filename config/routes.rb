Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create] do
    member do
      get :followings
      get :followers
      get :favorite_questions
    end
  end
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :questions, only: [:new, :show, :create, :destroy] do
   resources :answers, only: [:create]
 end
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
