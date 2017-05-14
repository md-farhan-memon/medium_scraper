Rails.application.routes.draw do
  root to: 'blogs#latest'
  mount ActionCable.server => '/cable'

  resource :users, only: [:new, :create] do
    collection do
      get :new_session
      post :login
      delete :logout
    end
  end

  resources :blogs, only: [:index, :show] do
  end

  resources :bloggers, only: [:show]

  resources :tags

  resource :scrape, only: [:new] do
    collection do
      get :latest
      post :pull
    end
  end
end
