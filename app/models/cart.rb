class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  has_one :order, dependent: :destroy

 # def create_order(user:, total:)
 #    order = Order.new(cart: self, user: user, total: total_amount, status: "created")
 #    cart_items.each do |cart_item|
 #      order_item = order.cart_item.build(product: cart_item.product, quantity: cart_item.quantity )
 #      order_item.order = order
 #    end
 #    order.save!
 #  end

  def create_order(user:, total:)
     Order.new(cart: self, user: user, total: total, status: "success")
  end

  def total_amount
     cart_items.sum { |item| item.product.price * item.quantity }
   end
end
