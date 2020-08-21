Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
    get 'profiles', to: 'users/registrations#edit_profile'
  end
  root 'items#index'

  resources :items do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  resources :items do
    member do
      post 'purchase'
      get 'purchased'
      get 'buy'
    end
  end
  
  resources :users, only: [:show, :edit, :update, :destroy] 
  resources :profiles, only: [:edit, :update]
  resources :cards, only: [:new, :create, :show, :destroy]
  
end
