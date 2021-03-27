Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  resources :user_friends, only: [:create]
  devise_for :users
  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
  get 'my_friends', to: 'users#my_friends'
  # check user controller after this
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
