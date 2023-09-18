# spec/checkout_spec.rb

require_relative '../lib/checkout'
require_relative '../lib/cart'
require_relative '../lib/product'

describe Checkout do
  let(:gr_product) { Product.new('GR1', 'Green Tea', 3.11) }
  let(:sr_product) { Product.new('SR1', 'Strawberries', 5.00) }
  let(:cf_product) { Product.new('CF1', 'Coffee', 11.23) }

  let(:cart) { Cart.new }
  let(:checkout) { Checkout.new(cart) }

  describe '#total' do
    it 'returns the correct total price for the given GR1,GR1 basket' do
      cart.add_item(gr_product)
      cart.add_item(gr_product)
      expect(checkout.total).to eq(3.11)
    end

    it 'returns the correct total price for the given SR1,SR1 ,GR1,SR1 basket' do
      cart.add_item(sr_product)
      cart.add_item(sr_product)
      cart.add_item(gr_product)
      cart.add_item(sr_product)
      expect(checkout.total).to eq(16.61)
    end

    it 'returns the correct total price for the given GR1,CF1,SR1,CF1,CF1 basket' do
      cart.add_item(gr_product)
      cart.add_item(cf_product)
      cart.add_item(sr_product)
      cart.add_item(cf_product)
      cart.add_item(cf_product)
      expect(checkout.total).to eq(30.57)
    end

  end
end
