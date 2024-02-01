class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def subtotal
    price * quantity
  end
end
