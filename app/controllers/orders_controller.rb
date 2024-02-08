class OrdersController < ApplicationController
  before_action :set_cart

  def create
    Order.transaction do
      @order = @cart.create_order(user: current_user, total: @cart.total_amount)
      if @order.save!
        flash.now[:notice] = "Order created successfully"
        respond_to do |format|
              format.turbo_stream do
                render turbo_stream: [turbo_stream.replace('cart',
                                                          partial: 'cart/cart',
                                                          locals: { cart: @cart }),
                                      turbo_stream.replace(@product)]
          end
      end
      else
        # handle failed payment processing
        redirect_to root_path, status: :unprocessable_entity
      end
    end
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
