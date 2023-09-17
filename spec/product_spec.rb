# spec/product_spec.rb

require_relative '../lib/product'

RSpec.describe Product do
  describe '#initialize' do

    it 'creates a product with the correct attributes' do
      product = Product.new('GR1', 'Green Tea', 3.11).save
      expect(product.code).to eq 'GR1'
      expect(product.name).to eq 'Green Tea'
      expect(product.base_price).to eq 3.11
    end

     it 'throws an error for negative price' do
      expect { Product.new('GR1', 'Green Tea', -3.11).save }.to raise_error(ArgumentError)
    end

    it 'throws an error for empty code' do
      expect { Product.new(nil, 'Green Tea', 3.11).save }.to raise_error(ArgumentError)
    end

    it 'throws an error for empty name' do
      expect { Product.new('GR1', nil, 3.11).save }.to raise_error(ArgumentError)
    end

    it 'throws an error for non-string code' do
      expect { Product.new(123, 'Green Tea', 3.11).save }.to raise_error(ArgumentError)
    end
  end

  describe '#calculate_price' do
    it 'calculates the price correctly' do
      product = Product.new('GR1', 'Green Tea', 3.11).save
      expect(product.calculate_price(2)).to eq(6.22)
    end

    it 'throws an error for negative quantity' do
      product = Product.new('GR1', 'Green Tea', 3.11).save
      expect { product.calculate_price(-2) }.to raise_error(ArgumentError)
    end

  end
end
