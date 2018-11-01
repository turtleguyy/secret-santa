Rails.application.routes.draw do
  unauthenticated do
    root to: 'devise/sessions#new'
  end

  authenticated do
    root to: 'user#show'
  end

  devise_for :users

  resources :users do
    resources :families
  end
end
