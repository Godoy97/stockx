class OrdersController < ApplicationController
  before_action :set_product, only: %i[new create edit update ]
  before_action :set_order, only: %i[show edit update status ]

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.product_id = @product.id
    @order.amount = @product.price
    @order.user = current_user
    @order.status = "Pending" #Reservado en el view, poner un popup de pago fake. que haga el cambio
    #del status a pagado!

    if @order.save
      redirect_to product_path(@product)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def status
    if params[:status] == "sold"
      @order.status = "Sold"
      @order.product.stock += -1
    else
      @order.status = "Rejected"
    end
    @order.save
    redirect_to edit_order_path(@order)
  end

  # def update
  #   @order.status = "Sold"
  #   if @order.save
  #     redirect_to product_path(@product)
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  #   # status = "Vendido"
  #     #product.stock = product.stock - 1

  #   # if stock > 0

  # end

  private

  def order_params
    params.require(:order).permit(:comment, :address)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
