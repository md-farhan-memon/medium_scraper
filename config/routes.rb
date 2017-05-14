Rails.application.routes.draw do
  root to: 'blogs#latest'

  resource :users, only: [:new, :create] do
    collection do
      get :new_session
      post :login
      delete :logout
    end
  end

  resources :blogs, only: [:index, :show]

  resources :bloggers, only: [:show]

  resource :scrape, only: [] do
    collection do
      post :pull
    end
  end
end
