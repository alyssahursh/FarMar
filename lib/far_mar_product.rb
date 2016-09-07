# far_mar_product.rb

require_relative '../far_mar.rb'
# require_relative '../support/products.csv'

#
# Each product belongs to a product. The `product_id` field refers to the `FarMar::Product` ID field. The `FarMar::Product` data, in order in the CSV, consists of:
#
# 1. ID - (Fixnum) uniquely identifies the product
# 2. Name - (String) the name of the product (not guaranteed unique)
# 3. Product_id - (Fixnum) a reference to which product sells this product


class FarMar::Product

  attr_reader :product_id

  def initialize(product_hash)
    @product_id = product_hash[:product_id] # (Fixnum) a unique identifier for that product
    @product_name = product_hash[:product_name] # (String) the name of the product (not guaranteed unique)
    @vendor_id = product_hash[:vendor_id] # (Fixnum) a reference to which product sells this product
  end

  def self.all

    all_product_instances = []

    CSV.open('/Users/alyssa/ada/Week5/FarMar/support/products.csv', 'r').each do |line|
      product_hash = {}
      product_hash[:product_id] = line[0].to_i
      product_hash[:product_name] = line[1]
      product_hash[:vendor_id] = line[2].to_i
      product = FarMar::Product.new(product_hash)
      all_product_instances << product
    end

    return all_product_instances

  end

  def self.find(id)
    array = all
    array.each do |product|
      if product.product_id == id
        return product
      end
    end
  end


end
