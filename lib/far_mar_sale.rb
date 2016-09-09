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
      sale_hash[:purchase_time] = DateTime.strptime(line[2], '%Y-%m-%d %H:%M:%S %z')
      sale_hash[:vendor_id] = line[3].to_i
      sale_hash[:product_id] = line[4].to_i
      sale = FarMar::Sale.new(sale_hash)
      all_sale_instances << sale
    end

    return all_sale_instances

  end

  def self.find(id)
    raise ArgumentError, "Sale ID must be numeric" if id =~ /[[:alpha][:punct:][:blank:]]/

    array = all
    array.each do |this_sale|
      if this_sale.sale_id == id
        return this_sale
      end
    end

    raise ArgumentError, "Vendor ID not found"

  end

  # vendor: returns the FarMar::Vendor instance that is associated with this sale using the FarMar::Sale vendor_id field
  def vendor
    return FarMar::Vendor.find(vendor_id)
  end

  # product: returns the FarMar::Product instance that is associated with this sale using the FarMar::Sale product_id field
  def product
    return FarMar::Product.find(product_id)
  end

  # self.between(beginning_time, end_time): returns a collection of FarMar::Sale objects where the purchase time is between the two times given as arguments
  def self.between(beginning_time, end_time)
    if beginning_time > end_time
      beginning_time, end_time = end_time, beginning_time
    end

    sales_between = []
    all_sales = all
    all_sales.each do |this_sale|
      if this_sale.purchase_time >= beginning_time && this_sale.purchase_time <= end_time
        sales_between << this_sale
      end
    end
    return sales_between
  end


end
