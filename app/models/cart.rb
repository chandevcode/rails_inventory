class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def subtotal
    line_items.sum(&:subtotal)
  end

  def total
    subtotal
  end
end
