class ProductsController < ApplicationController
  before_action :require_user, except: [:add_to_cart]
  before_action :find_product, except: [:new, :create, :index, :add_to_cart]

  def index
  	if params[:search].present?
  		@tag_ids = Tag.where("name ilike ?", params[:search]).pluck(:id)
  		@search = Product.joins(:product_tags).where("product_tags.tag_id IN (?)",@tag_ids)
  	else
    	@search = Product.all
  	end
    @products = @search.order("name asc").paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @product = Product.new
    @product_images = @product.images.build
    @product_images = @product.product_tags.build
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: 'Product created successfully.'
    else
      flash[:notice] = @product.errors.full_messages.first
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update_attributes(product_params)
      redirect_to products_path, notice: 'Product updated successfully.'
    else
      flash[:notice] = @product.errors.full_messages.first
      render :edit
    end
  end

  def show
  end

  def destroy
    if @product.destroy
      redirect_to products_path, notice: 'Product destroyed successfully.'
    else
      render :edit
    end
  end

  def add_to_cart
  	@product = Product.find_by(id: params[:product_id])
  	@user = User.find_by(id: params[:user_id])
  	@cart_product = @product.cart_products.find_or_create_by(user_id: @user.id)
  	@cart_product.update_attributes(quantity: @cart_product.quantity + params[:quantity].to_i)
  	@count = @user.cart_products.count
  	render :json => {:status  => true, count: @count}
  end

  private

  def find_product
    @product = Product.find_by(id: params[:id])
    redirect_to products_path unless @product
  end

  def product_params
    params.require(:product).permit(:name,:description,:price, images_attributes: [:id, :file, :imageable_id,:imageable_type,:_destroy], product_tags_attributes: [:id, :product_id, :tag_id,:_destroy])
  end
end
