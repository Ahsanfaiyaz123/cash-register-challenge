# lib/cart.rb
require_relative 'pricing_rules'

class Cart
  attr_reader :items, :total_price

  def initialize
    setup_cart
  end

  def add_item(product, quantity=1)
    validate_add_item(product, quantity)

    @items[product.code] += quantity
    update_total_price(product.base_price, quantity)
  end

  def total_price
    (@total_price ||= calculate_total_price).round(2)
  end

  def apply_pricing_rules
    discounted_product_rules.each do |product_code, discount_method|

      next unless PricingRules.respond_to? discount_method

      @total_price -= PricingRules.send(discount_method, items, product_code)
    end
  end

  def setup_cart
    @items = Hash.new(0)
    @total_price = 0.0
  end

  def clear
    setup_cart
  end

  def display
    puts 'Cart Contents:'
    items.each do |product_code, quantity|
      product = Product.find(product_code)
      puts "#{quantity} x #{product.name} - #{product.calculate_price(quantity)}€"
    end
    puts "Total: #{total_price}€"
  end

  private

  def discounted_product_rules
    {
      'GR1' => :apply_buy_one_get_one_free_rule,
      'SR1' => :apply_bulk_discount_rule,
      'CF1' => :apply_coffee_addict_discount_rule
    }
  end

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
