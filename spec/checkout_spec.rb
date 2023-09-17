# spec/checkout_spec.rb

require_relative '../lib/checkout'
require_relative '../lib/cart'
require_relative '../lib/product'

describe Checkout do
  let(:product1) { Product.new('GR1', 'Green Tea', 3.11) }
  let(:product2) { Product.new('SR1', 'Strawberries', 5.00) }
  let(:product3) { Product.new('CF1', 'Coffee', 11.23) }

  let(:cart) { Cart.new }
  let(:checkout) { Checkout.new(cart) }

  describe '#total' do
    it 'returns the correct total price for the given GR1,GR1 basket' do
      cart.add_item(product1)
      cart.add_item(product1)
      expect(checkout.total).to eq(3.11)
    end

    it 'returns the correct total price for the given SR1,SR1 ,GR1,SR1 basket' do
      cart.add_item(product2)
      cart.add_item(product2)
      cart.add_item(product1)
      cart.add_item(product2)
      expect(checkout.total).to eq(16.61)
    end

    it 'returns the correct total price for the given GR1,CF1,SR1,CF1,CF1 basket' do
      cart.add_item(product1)
      cart.add_item(product3)
      cart.add_item(product2)
      cart.add_item(product3)
      cart.add_item(product3)
      expect(checkout.total).to eq(30.57)
    end

  end
end
