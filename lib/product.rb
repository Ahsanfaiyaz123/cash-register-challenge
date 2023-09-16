# lib/product.rb

class Product
  attr_reader :code, :name, :base_price

  def initialize(code, name, base_price)
    validate_input(code, name, base_price)

    @code = code
    @name = name
    @base_price = base_price
  end

  def calculate_price(quantity)
    validate_quantity(quantity)

    base_price * quantity
  end

  private

  def validate_input(code, name, base_price)
    raise ArgumentError, 'Code, name, and base_price must be provided' if code.nil? || name.nil? || base_price.nil?
    raise ArgumentError, 'Price cannot be negative' if base_price < 0
    raise ArgumentError, 'Code must be a string' unless code.is_a?(String)
  end

  def validate_quantity(quantity)
    raise ArgumentError, 'Quantity cannot be negative' if quantity < 0
  end
end
