class ApplicationController < ActionController::Base
 before_action :set_render_cart
  before_action :initialize_cart

  def set_render_cart
    @render_cart = true
  end

  def initialize_cart
    @cart ||= cart.find_by(id: session[:cart_id])

    if @cart.nil?
      @cart = cart.create
      session[:cart_id] = @cart.id
    end
  end
end
