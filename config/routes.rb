Rails.application.routes.draw do
  resources :carts, only: [:show] do
    member do
      get :add_product
    end
  end
  resources :products
  root "products#index"
end
