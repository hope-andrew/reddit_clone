Rails.application.routes.draw do
  resources :posts do
    resources :comments, only: [:new]
  end
  resources :subs
  resources :users
  resources :comments, only: [:create, :show]

  resource :session

end
