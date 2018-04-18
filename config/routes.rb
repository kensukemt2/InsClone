Rails.application.routes.draw do

  root to: 'contributions#top'
  resources :contributions
  resources :users do
    collection do
      post :confirm
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  resources :favorites, only: [:create, :destroy]
end
