class CartProductsController < ApplicationController
	before_action :require_user
  
  def index
  	 @cart_products = current_user.cart_products
  end
end
