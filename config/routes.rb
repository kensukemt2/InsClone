Rails.application.routes.draw do

  root to: 'contributions#top'
  resources :contributions do
    collection do
      post :confirm1
    end
  end

  resources :users do
    collection do
      post :confirm
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  resources :favorites, only: [:create, :destroy]
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
