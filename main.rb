# main.rb

require_relative 'lib/cart'
require_relative 'lib/product'
require_relative 'lib/checkout'

# Setup some products
gr_product = Product.new('GR1', 'Green Tea', 3.11).save
sr_product = Product.new('SR1', 'Strawberries', 5.00).save
cf_product = Product.new('CF1', 'Coffee', 11.23).save

cart = Cart.new
checkout = Checkout.new(cart)

def display_available_products
  puts 'Available Products:'
  Product.all.each do |code, product|
    puts "#{code} - #{product.name} - #{product.base_price}€"
  end
end

loop do
  puts "\nOptions:"
  puts '1. Add product to cart'
  puts '2. View all products'
  puts '3. View cart'
  puts '4. Clear cart'
  puts '5. Checkout'
  puts '6. Exit'
  print 'Enter your choice: '

  choice = gets.chomp.to_i

  case choice
  when 1
    display_available_products
    print 'Enter product code to add: '
    product_code = gets.chomp
    product = Product.find(product_code)

    if product
      print 'Enter quantity: '
      quantity = gets.chomp.to_i
      cart.add_item(product, quantity)
      puts "Added #{quantity} #{product.name} to the cart."
    else
      puts 'Invalid product code.'
    end
  when 2
    display_available_products
  when 3
    cart.display
  when 4
    cart.clear
  when 5
    puts "Total price after discounts: #{checkout.total}€"
    cart.clear
  when 6
    break
  else
    puts 'Invalid choice. Please try again.'
  end
  rescue => e
    puts e.message
end
