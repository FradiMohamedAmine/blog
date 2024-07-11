Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :articles do
    resources :comments do
      member do
        post :like
        post :dislike
      end
    end
  end

  mount ActionCable.server => "/cable"
end
