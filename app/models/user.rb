class User < ApplicationRecord
  has_one :cart, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # def cart
  #   self.build_cart unless self.cart
  #   self.cart
  # end
end
