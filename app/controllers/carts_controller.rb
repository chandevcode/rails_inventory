class CartsController < ApplicationController
  def show
    @render_cart = false
  end

  def add
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_order = @cart.cart_items.find_by(product_id: @product.id)
    if current_order && quantity > 0
      current_order.update(quantity:)
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
end
