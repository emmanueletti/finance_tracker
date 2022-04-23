Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :user_stocks, only: [:create]
  root 'welcome#index'

  get 'my-portfolio', to: 'users#my_portfolio'
  get 'search-stock', to: 'stocks#search'
end
