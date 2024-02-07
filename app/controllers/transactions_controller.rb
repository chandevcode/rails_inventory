class TransactionsController < ApplicationController
  def create
    @cart = current_cart
    @transaction = @cart.transactions.new
    @transaction.cart_id = @cart.id
    @transaction.product_id = params[:product_id]
    @transaction.quantity = params[:quantity]
    @transaction.price = Product.find(params[:product_id]).price

    if @transaction.save
      # Create a new order for the transaction
      order = Order.create!(cart: @cart)

      # Update the quantity of the product in the inventory
      product = Product.find(@transaction.product_id)
      product.update_column(:quantity, product.quantity - @transaction.quantity)

      # Clear the cart
      @cart.cart_items.destroy_all

      # Redirect to the order show page
      redirect_to order_path(order)
    else
      render :new
    end
  end
end
