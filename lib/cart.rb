# lib/cart.rb

class Cart
  attr_reader :items, :total_price

  def initialize
    @items = Hash.new(0)
    @total_price = 0.0
  end

  def add_item(product, quantity=1)
    validate_add_item(product, quantity)

    @items[product.code] += quantity
    update_total_price(product.base_price, quantity)
  end

  def total_price
    @total_price ||= calculate_total_price
  end

  private

  def update_total_price(base_price, quantity)
    @total_price += base_price * quantity
  end

  def validate_add_item(product, quantity)
    raise ArgumentError, 'Product is invalid' unless product.is_a?(Product)
    raise ArgumentError, 'Quantity cannot be negative' if quantity.negative?
  end

  def calculate_total_price
    items.sum { |code, quantity| Product.find(code).base_price * quantity }
  end
end
