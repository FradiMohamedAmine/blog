Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :articles do
    resources :comments do
      resources :reactions, only: :create
    end
    resources :reactions, only: :create
  end


  namespace :api do
    resources :articles, only: [:index, :show, :create, :update, :destroy] do
      resources :comments, only: [:create]
      resources :reactions, only: [:create]
    end

    resources :comments, only: [] do
      resources :reactions, only: [:create]
    end
  end



  mount ActionCable.server => "/cable"
end
