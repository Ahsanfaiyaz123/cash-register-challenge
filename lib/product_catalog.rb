# lib/product_catalog.rb

module ProductCatalog
  @products = Hash.new(0)

  def self.add_product(product)
    @products[product.code] = product
  end

  def self.products
    @products
  end
end
