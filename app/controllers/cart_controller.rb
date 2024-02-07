class CartController < ApplicationController
  def show
    @render_cart = false
    @cart = current_cart
  end

  def add
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_order = @cart.cart_items.find_by(product_id: @product.id)
    if current_order && quantity > 0
      current_order.update(quantity: current_order.quantity + quantity)
    elsif quantity <= 0
      @cart.cart_items.destroy
    else
      @cart.cart_items.create(product: @product, quantity:)
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart }),
                              turbo_stream.replace(@product)]
      end
    end
  end

  def remove
    CartItem.find_by(id: params[:id]).destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('cart',
                                                  partial: 'cart/cart',
                                                  locals: { cart: @cart })
      end
    end
  end

  def checkout
    @cart = current_cart
  end
end
