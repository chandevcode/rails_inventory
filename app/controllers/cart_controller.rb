class CartController < ApplicationController
  def show
    @render_cart = false
  end

  def add
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_order = @cart.cart_items.find_by(product_id: @product.id)

    if current_order && quantity.positive?
      CartItem.transaction do
        current_order.update(quantity: current_order.quantity + quantity)
        @cart.save!
      end
    elsif quantity <= 0
      CartItem.transaction do
        current_order.destroy if current_order
        @cart.save!
      end
    else
      CartItem.transaction do
        @cart.cart_items.create!(product: @product, quantity:)
        @cart.save!
      end
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart }),
                              turbo_stream.replace(@product)]
      end
    end
  end

  def remove
    CartItem.transaction do
      CartItem.find_by(id: params[:id]).destroy
      @cart.save!
    end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('cart',
                                                  partial: 'cart/cart',
                                                  locals: { cart: @cart })
      end
    end
  end
end
