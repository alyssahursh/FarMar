# far_mar_vendor.rb

require_relative '../far_mar.rb'

class FarMar::Vendor

  attr_reader :vendor_id, :market_id

  def initialize(vendor_hash)
    @vendor_id = vendor_hash[:vendor_id] # (Fixnum) a unique identifier for that vendor
    @vendor_name = vendor_hash[:vendor_name] # (String) the name of the vendor (not guaranteed unique)
    @vendor_num_employees = vendor_hash[:vendor_num_employees] # (Fixnum) How many employees the vendor has at the market
    @market_id = vendor_hash[:market_id] # (Fixnum) a reference to which market the vendor attends
  end

  def self.all

    all_vendor_instances = []

    CSV.open('/Users/alyssa/ada/Week5/FarMar/support/vendors.csv', 'r').each do |line|
      vendor_hash = {}
      vendor_hash[:vendor_id] = line[0].to_i
      vendor_hash[:vendor_name] = line[1]
      vendor_hash[:vendor_num_employees] = line[2]
      vendor_hash[:market_id] = line[3].to_i
      vendor = FarMar::Vendor.new(vendor_hash)
      all_vendor_instances << vendor
    end

    return all_vendor_instances

  end


  def self.find(id)
    raise ArgumentError, "Vendor ID must be numeric" if id =~ /[[:alpha][:punct:][:blank:]]/

    all.each do |vendor|
      if vendor.vendor_id == id
        return vendor
      end
    end

    raise ArgumentError, "Vendor ID not found"

  end

  # market: returns the FarMar::Market instance that is associated with this vendor using the FarMar::Vendor market_id field
  def market
    market = FarMar::Market.find(market_id)
  end

  # products: returns a collection of FarMar::Product instances that are associated by the FarMar::Product vendor_id field.
  def products
    product_array = []
    all_products = FarMar::Product.all
    all_products.each do |product|
      if product.vendor_id == vendor_id
        product_array << product
      end
    end
    product_array
  end

  # sales: returns a collection of FarMar::Sale instances that are associated by the vendor_id field.
  def sales
    sale_array = []
    all_sales = FarMar::Sale.all
    all_sales.each do |sale|
      if sale.vendor_id == @vendor_id
        sale_array << sale
      end
    end
    sale_array
  end

  # revenue: returns the the sum of all of the vendor's sales (in cents)
  def revenue
    total_vendor_revenue = 0
    sale_array = sales
    sale_array.each do |sale|
      total_vendor_revenue += sale.sale_amount
    end
    total_vendor_revenue
  end

  # self.by_market(market_id): returns all of the vendors with the given market_id
  def self.by_market(market_id)
    vendors_by_market = []
    all.each do |vendor|
      if vendor.market_id == market_id
        vendors_by_market << vendor
      end
    end
    vendors_by_market
  end

  # self.most_revenue(n) returns the top n vendor instances ranked by total revenue
  # def self.most_revenue(n)
  # end
  #
  # # self.most_items(n) returns the top n vendor instances ranked by total number of items sold
  # def self.most_items(n)
  # end
  #
  # # self.revenue(date) returns the total revenue for that date across all vendors
  # def self.revenue(date)
  # end
  #
  # # revenue(date) returns the total revenue for that specific purchase date and vendor instance
  # def revenue(date)
  # end




end
