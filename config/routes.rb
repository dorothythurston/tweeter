Rails.application.routes.draw do
  root to: "homes#show"
  resources :users, only: [:new, :create] do
    resources :password_resets, only: [:edit, :update]
  end
  resources :password_resets, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
end
