Rails.application.routes.draw do
  get 'orders/create'

  devise_for :users

  get 'cart', to: 'cart#show'
  post 'cart/add'
  post 'cart/remove'
  post 'cart/create'

  resources :orders, only: [:create]

  resources :products

  root 'products#index'
end
