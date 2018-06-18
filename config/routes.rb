Rails.application.routes.draw do
  root to: "homes#show"
  resources :users, only: [:new, :create] do
    resources :password_resets, only: [:edit, :update]
  end
  resources :password_resets, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  
  resources :tweets, only: [:index]

  resources :users do
    resources :tweets, only: [:index, :new, :create]
  end
end
