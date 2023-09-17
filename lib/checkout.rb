# lib/checkout.rb

class Checkout
  def initialize(cart = Cart.new)
    @cart = cart
  end

  def scan(item_code)
    product = Product.find(item_code)
    @cart.add_item(product)
  end

  def total
    @cart.apply_pricing_rules
    @cart.total_price
  end
end
