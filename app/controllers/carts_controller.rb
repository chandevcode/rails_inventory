class CartsController < ApplicationController
  def add_product
    product = Product.find(params[:product_id])
    @cart_item = @cart.cart_items.find_or_create_by(product: product)
    @cart_item.quantity += 1
    @cart.save
    redirect_to cart_path(@cart), notice: 'Success add to cart'
  end
end
