Rails.application.routes.draw do

  get 'cart_products/index'
 root :to => "products#index"
  resources :sessions
  resources :products do
  	collection do
  		post :add_to_cart
  	end
  end
  resources :tags
  resources :orders
  resources :cart_products
end
