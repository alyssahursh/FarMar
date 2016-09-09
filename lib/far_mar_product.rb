# far_mar_product.rb

require_relative '../far_mar.rb'

class FarMar::Product

  attr_reader :product_id, :vendor_id

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
    raise ArgumentError, "Product ID must be numeric" if id =~ /[[:alpha][:punct:][:blank:]]/

    array = all
    array.each do |product|
      if product.product_id == id
        return product
      end
    end

    raise ArgumentError, "Product ID not found"

  end

  # vendor: returns the FarMar::Vendor instance that is associated with this vendor using the FarMar::Product vendor_id field
  def vendor
    return FarMar::Vendor.find(@vendor_id)
  end

  # sales: returns a collection of FarMar::Sale instances that are associated using the FarMar::Sale product_id field.
  def sales
    sales_array = []
    sale_list = FarMar::Sale.all
    sale_list.each do |sale|
      if sale.product_id == @product_id
        sales_array << sale
      end
    end
    sales_array
  end

  # number_of_sales: returns the number of times this product has been sold.
  def number_of_sales
    return sales.length
  end

  # self.by_vendor(vendor_id): returns all of the products with the given vendor_id
  def self.by_vendor(vendor_id)
    vendor_products = []
    all_products = all
    all.each do |product|
      if product.vendor_id == vendor_id
        vendor_products << product
      end
    end
    vendor_products
  end

end
