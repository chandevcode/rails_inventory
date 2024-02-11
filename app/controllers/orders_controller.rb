class OrdersController < ApplicationController
  before_action :set_cart

  def index
    @orders = Order.all.order(created_at: :desc)
  end

  def create
    Order.transaction do
      @order = @cart.create_order(user: current_user, total: @cart.total_amount)
      if @order.save!
        flash.now[:notice] = 'Order created successfully'
      else
        redirect_to root_path, status: :unprocessable_entity
      end
    end
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
