# spec/cart_spec.rb

require_relative '../lib/cart'
require_relative '../lib/product'

describe Cart do
  let(:gr_product) { Product.new('GR1', 'Green Tea', 3.11).save }
  let(:sr_product) { Product.new('SR1', 'Strawberries', 5.00).save }
  let(:cf_product) { Product.new('CF1', 'Coffee', 11.23).save }

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
      cart.add_item(gr_product)
      expect(cart.items).to eq({ 'GR1' => 1 })
      expect(cart.total_price).to eq(3.11)
    end

    it 'raises an error for invalid product' do
      expect { cart.add_item('Invalid Product') }.to raise_error(ArgumentError, 'Product is invalid')
    end

    it 'raises an error for negative quantity' do
      expect { cart.add_item(gr_product, -2) }.to raise_error(ArgumentError, 'Quantity cannot be negative')
    end
  end

  describe '#total_price' do
    let(:cart) { Cart.new }

    it 'returns 0.0 for an empty cart' do
      expect(cart.total_price).to eq(0.0)
    end

    it 'returns the correct total price for items in the cart' do
      cart.add_item(gr_product)
      cart.add_item(sr_product, 2)
      cart.add_item(cf_product)
      expect(cart.total_price).to eq(3.11 + (2 * 5.00) + 11.23)
    end

    it 'updates total_price when adding an item' do
      cart.add_item(gr_product)
      expect(cart.total_price).to eq(3.11)
      cart.add_item(sr_product)
      expect(cart.total_price).to eq(3.11 + 5.00)
    end

    it 'recalculates total_price when adding an item' do
      cart.add_item(gr_product)
      expect(cart.total_price).to eq(3.11)
      cart.add_item(gr_product)
      expect(cart.total_price).to eq(2 * 3.11)
    end

    it 'updates total_price when quantity of an item is changed' do
      cart.add_item(gr_product)
      cart.add_item(sr_product, 2)
      expect(cart.total_price).to eq(3.11 + 2 * 5.00)
      cart.add_item(sr_product, 1)
      expect(cart.total_price).to eq(3.11 + 3 * 5.00)
    end
  end

  describe '#apply_pricing_rules' do
    let(:cart) { Cart.new }

    it 'applies the buy-one-get-one-free rule for Green Tea (GR1)' do
      cart.add_item(gr_product, 2) # Adding 2 Green Teas
      expect { cart.apply_pricing_rules }.to change { cart.total_price }.from(6.22).to(3.11)
    end

    it 'applies the bulk discount for Strawberries (SR1)' do
      cart.add_item(sr_product, 3) # Adding 3 Strawberries
      expect { cart.apply_pricing_rules }.to change { cart.total_price }.from(15.00).to(13.50)
    end

    it 'applies the coffee addict discount for Coffee (CF1)' do
      cart.add_item(cf_product, 3) # Adding 3 Coffees
      expect { cart.apply_pricing_rules }.to change { cart.total_price }.from(33.69).to(22.46)
    end

    it 'does not apply any discounts for products with quantity less than the discount threshold' do
      cart.add_item(gr_product) # Adding 1 Green Tea
      expect { cart.apply_pricing_rules }.not_to change { cart.total_price }
    end

    it 'does not apply discounts for products not in the discount rules' do
      cart.add_item(Product.new('XX1', 'Random Product', 10.00).save, 3) # Adding 3 of a non-discounted product
      expect { cart.apply_pricing_rules }.not_to change { cart.total_price }
    end
  end

end
