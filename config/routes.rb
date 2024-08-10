Rails.application.routes.draw do
resources :users
post '/auth/login', to: 'authentication#login'
resources :products, only: [:index, :show, :create, :update, :destroy]
get 'my_products', to: 'products#my_products'
end
