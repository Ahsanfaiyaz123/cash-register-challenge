# spec/cart_spec.rb

require_relative '../lib/cart'
require_relative '../lib/product'

describe Cart do
  let(:product1) { Product.new('GR1', 'Green Tea', 3.11) }
  let(:product2) { Product.new('SR1', 'Strawberries', 5.00) }
  let(:product3) { Product.new('CF1', 'Coffee', 11.23) }

  describe '#initialize' do
    it 'initializes an empty cart' do
      cart = Cart.new
      expect(cart.items).to be_empty
      expect(cart.total_price).to eq(0.0)
    end
  end

  describe '#add_item' do
    let(:cart) { Cart.new }

    it 'adds an item to the cart' do
      cart.add_item(product1)
      expect(cart.items).to eq({ 'GR1' => 1 })
      expect(cart.total_price).to eq(3.11)
    end

    it 'raises an error for invalid product' do
      expect { cart.add_item('Invalid Product') }.to raise_error(ArgumentError, 'Product is invalid')
    end

    it 'raises an error for negative quantity' do
      expect { cart.add_item(product1, -2) }.to raise_error(ArgumentError, 'Quantity cannot be negative')
    end
  end

  describe '#total_price' do
    let(:cart) { Cart.new }

    it 'returns 0.0 for an empty cart' do
      expect(cart.total_price).to eq(0.0)
    end

    it 'returns the correct total price for items in the cart' do
      cart.add_item(product1)
      cart.add_item(product2, 2)
      cart.add_item(product3)
      expect(cart.total_price).to eq(3.11 + (2 * 5.00) + 11.23)
    end

    it 'updates total_price when adding an item' do
      cart.add_item(product1)
      expect(cart.total_price).to eq(3.11)
      cart.add_item(product2)
      expect(cart.total_price).to eq(3.11 + 5.00)
    end

    it 'recalculates total_price when adding an item' do
      cart.add_item(product1)
      expect(cart.total_price).to eq(3.11)
      cart.add_item(product1)
      expect(cart.total_price).to eq(2 * 3.11)
    end

    it 'updates total_price when quantity of an item is changed' do
      cart.add_item(product1)
      cart.add_item(product2, 2)
      expect(cart.total_price).to eq(3.11 + 2 * 5.00)
      cart.add_item(product2, 1)
      expect(cart.total_price).to eq(3.11 + 3 * 5.00)
    end
  end
end
