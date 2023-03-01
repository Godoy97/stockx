class OrdersController < ApplicationController
  before_action :set_product, only: %i[new create edit update ]
  before_action :set_order, only: %i[show edit update status ]

  def index
    # @orders = Order.all
    @orders = policy_scope(Order)
  end

  def new
    @order = Order.new
    authorize @order
  end

  def create
    @order = Order.new(order_params)
    @order.product_id = @product.id
    @order.amount = @product.price
    @order.user = current_user
    @order.status = "pending" #Reservado en el view, poner un popup de pago fake. que haga el cambio
    #del status a pagado!

    if @order.save
      redirect_to order_path(@order)
    else
      render :new, status: :unprocessable_entity
    end
    authorize @order
  end

  def show
    authorize @order
  end

  def edit
  end

  def status
    if params[:status] == "waiting-payment"
      @order.status = "waiting-payment"
    elsif params[:status] == "sold"
      @order.status = "sold"
      @order.product.stock += -1
    else
      @order.status = "rejected"
    end
    @order.save
    redirect_to edit_order_path(@order)
    authorize @order
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
