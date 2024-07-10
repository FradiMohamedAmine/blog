Rails.application.routes.draw do
  root "articles#index"
  mount ActionCable.server => "/cable"

  resources :articles do
    resources :comments do
      member do
        post :like
        post :dislike
      end
    end
  end
end
