# far_mar_sale.rb
require 'date'

require_relative '../far_mar.rb'
# require_relative '../support/sales.csv'


# Each sale belongs to a sale __AND__ a product. The `sale_id` and `product_id` fields refer to the `FarMar::Sale` and `FarMar::Product` ID fields, respectively. The `FarMar::Sale` data, in order in the CSV, consists of:
#
# 1. ID - (Fixnum) uniquely identifies the sale
# 2. Amount - (Fixnum) the amount of the transaction, in cents (i.e., 150 would be $1.50)
# 3. Purchase_time - (Datetime) when the sale was completed
# 4. Vendor_id - (Fixnum) a reference to which sale completed the sale
# 5. Product_id - (Fixnum) a reference to which product was sold

class FarMar::Sale

  attr_reader :sale_id, :product_id, :vendor_id, :sale_amount, :purchase_time

  def initialize(sale_hash)
    @sale_id = sale_hash[:sale_id] # (Fixnum) a unique identifier for that sale
    @sale_amount = sale_hash[:sale_amount] # (Fixnum) the amount of the transaction, in cents (i.e., 150 would be $1.50)
    @purchase_time = sale_hash[:purchase_time] # (Datetime) when the sale was completed
    @vendor_id = sale_hash[:vendor_id] # (Fixnum) a reference to which vendor completed the sale
    @product_id = sale_hash[:product_id] # (Fixnum) a reference to which product was sold
  end

  def self.all

    all_sale_instances = []

    CSV.open('/Users/alyssa/ada/Week5/FarMar/support/sales.csv', 'r').each do |line|
      sale_hash = {}
      sale_hash[:sale_id] = line[0].to_i
      sale_hash[:sale_amount] = line[1].to_i
      sale_hash[:purchase_time] = Time.new(line[2])
      sale_hash[:vendor_id] = line[3].to_i
      sale_hash[:product_id] = line[4].to_i
      sale = FarMar::Sale.new(sale_hash)
      all_sale_instances << sale
    end

    return all_sale_instances

  end

  def self.find(id)
    array = all
    array.each do |sale|
      if sale.sale_id == id
        return sale
        break
      end
    end
  end

  # vendor: returns the FarMar::Vendor instance that is associated with this sale using the FarMar::Sale vendor_id field
  def vendor
    sale_vendor = FarMar::Vendor.find(vendor_id)
    sale_vendor
  end

  # product: returns the FarMar::Product instance that is associated with this sale using the FarMar::Sale product_id field
  def product
    sale_product = FarMar::Product.find(product_id)
    sale_product
  end

  # self.between(beginning_time, end_time): returns a collection of FarMar::Sale objects where the purchase time is between the two times given as arguments
  def self.between(beginning_time, end_time)
    sales_between = []
    all_sales = all
    all_sales.each do |sale|
      if sale.purchase_time > beginning_time && sale.purchase_time < end_time
        sales_between << sale
      end
    end
    sales_between
  end


end
