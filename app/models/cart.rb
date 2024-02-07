class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  has_one :order, dependent: :destroy

  # def total
  #   cart_items.to_a.sum { |cart_item| cart_item.total }
  # end
 def create_order(user:, total:)
    Order.new(cart: self, user: user, total: total, status: "created")
  end
  def total_amount
     cart_items.sum { |item| item.product.price * item.quantity }
   end

  # def checkout
  #   if payment_method == 'cash'
  #     update(checkout: true)
  #     true
  #   else
  #     false
  #   end
  # end
end
