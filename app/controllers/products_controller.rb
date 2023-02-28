class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  def index
    @products = Product.all
    @products_seller = Product.where(user_id: current_user.id)
    @products = policy_scope(Product)
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @user = User.find(current_user.id)
    @product = Product.new(product_params)
    @product.user = current_user
    @product.status = "available" # Paused
    if @product.save
      @user.seller = true
      @user.save
      redirect_to product_path(@product)
    else
      render :new, status: :unprocessable_entity
    end
    authorize @product
  end

  def show
    authorize @product
  end

  def edit
    authorize @product
  end

  def update
    authorize @product
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @product
    @product.destroy
    redirect_to products_path, status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :brand, :size, :color)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
