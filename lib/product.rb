# lib/product.rb

class Product
  attr_reader :code, :name, :base_price
  @@products = Hash.new {0}

  def initialize(code, name, base_price)
    @code = code
    @name = name
    @base_price = base_price
  end

  def calculate_price(quantity)
    validate_quantity(quantity)

    base_price * quantity
  end

  def save
    validate_input
    @@products[code] = self
  end

  def self.find(code)
    all.fetch(code) { raise ArgumentError, 'Invalid product code' }
  end

  def self.all
    @@products
  end

  private

  def validate_input
    raise ArgumentError, 'Code, name, and base_price must be provided' if code.nil? || name.nil? || base_price.nil?
    raise ArgumentError, 'Price cannot be negative' if base_price < 0
    raise ArgumentError, 'Code must be a string' unless code.is_a?(String)
  end

  def validate_quantity(quantity)
    raise ArgumentError, 'Quantity cannot be negative' if quantity < 0
  end
end
