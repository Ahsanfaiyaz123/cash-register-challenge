# lib/pricing_rules.rb
module PricingRules
  DISCOUNT_RULE_QUANTITY = { 'BOGO' => 2, 'ABD' => 3, 'ACD' => 3 }
  BULK_DISCOUNT_VALUE = 4.50
  COFFEE_DISCOUNT_VALUE = 2.0 / 3.0

  def self.apply_buy_one_get_one_free_rule(items, product_code)
    return 0.0 unless items[product_code] && items[product_code] >= DISCOUNT_RULE_QUANTITY['BOGO']

    product = Product.find(product_code)
    (items[product_code] / 2).floor * product.base_price
  end

  def self.apply_bulk_discount_rule(items, product_code)
    return 0.0 unless items[product_code] && items[product_code] >= DISCOUNT_RULE_QUANTITY['ABD']

    product = Product.find(product_code)
    items[product_code] * (product.base_price - BULK_DISCOUNT_VALUE)
  end

  def self.apply_coffee_addict_discount_rule(items, product_code)
    return 0.0 unless items[product_code] && items[product_code] >= DISCOUNT_RULE_QUANTITY['ACD']

    product = Product.find(product_code)
    items[product_code] * (product.base_price - (product.base_price * COFFEE_DISCOUNT_VALUE))
  end

end
