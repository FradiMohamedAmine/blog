Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :articles do
    resources :comments do
      resources :reactions, only: :create
    end
    resources :reactions, only: :create
  end

  mount ActionCable.server => "/cable"
end
