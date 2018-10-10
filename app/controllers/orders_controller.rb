class OrdersController < ApplicationController
  before_action :require_user
  def index
    @orders = Order.order("created_at desc").paginate(:page => params[:page], :per_page => 10)
  end

  def create
  	@cart_products = current_user.cart_products
    @total_order_amount = 0
    @cart_products.each do |x|
      @product_total_amount = (x.product.price.to_f * x.quantity)
      @total_order_amount = (@total_order_amount + @product_total_amount)
    end
    @tax_amount = ((@total_order_amount * 15) / 100)
    @total_amount = (@total_order_amount + @tax_amount).round(2)
    @order = current_user.orders.build
    @order.update_attributes(tax_amount: @tax_amount,total_price: @total_order_amount, total_amount: @total_amount)
    if @order.save
      @cart_products.each do |cart|
        @order.order_details.create(price: cart.product.price, quantity: cart.quantity, total_amount: (cart.product.price.to_f * cart.quantity), product_id: cart.product_id)
      end
      @cart_products = current_user.cart_products.destroy_all
      redirect_to products_path, notice: 'Order placed successfully.'
    else
    	redirect_to cart_products_path, notice: 'Unable to placed the order. Please try again.'
    end
  end

  def show
  	@order = Order.find_by(id: params[:id])
    @order_details = @order.order_details
  end
end
