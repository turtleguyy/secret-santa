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
  resources :families, except: :index do
    get 'assign'
    get 'new_member'
    patch 'join'
  end

  resources :members, only: [:new, :create, :destroy]

  get 'dashboard', to: 'dashboard#show'

  post 'family_members', to: 'members#get_members_by_family_code'
end
