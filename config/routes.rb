Rails.application.routes.draw do
  unauthenticated do
    devise_scope :user do
      root to: 'devise/sessions#new'
    end
  end

  authenticated do
    root to: 'dashboard#show'
  end

  devise_for :users

  resources :users, except: :index
  resources :families, except: :index
  resources :relationships, only: [:new, :create, :destroy]

  get 'dashboard', to: 'dashboard#show'
end
