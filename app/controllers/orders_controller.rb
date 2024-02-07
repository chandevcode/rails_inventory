class OrdersController < ApplicationController
  before_action :set_cart

  def create
    @order = @cart.create_order(user: current_user, total: @cart.total_price)
    if @order.save
      flash[:notice] = "Order created successfully"
      redirect_to root_path, status: :unprocessable_entity
    else
      # handle failed payment processing
      redirect_to root_path, status: :unprocessable_entity
    end
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
