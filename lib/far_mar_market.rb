# far_mar_market.rb

require_relative '../far_mar.rb'

class FarMar::Market

  attr_reader :market_id, :market_name, :market_address, :market_city, :market_county, :market_state, :market_zip

  def initialize(market_hash)
    @market_id = market_hash[:market_id] # (Fixnum) a unique identifier for that market
    @market_name = market_hash[:market_name] # (String) the name of the market (not guaranteed unique)
    @market_address = market_hash[:market_address] # (String) street address of the market
    @market_city = market_hash[:market_city] # (String) city in which the market is located
    @market_county = market_hash[:market_county] # (String) county in which the market is located
    @market_state = market_hash[:market_state] # (String) state in which the market is located
    @market_zip = market_hash[:market_zip] # (String) zipcode in which the market is located
  end

  def self.all

    all_market_instances = []

    CSV.open('/Users/alyssa/ada/Week5/FarMar/support/markets.csv', 'r').each do |line|
      market_hash = {}
      market_hash[:market_id] = line[0].to_i
      market_hash[:market_name] = line[1]
      market_hash[:market_address] = line[2]
      market_hash[:market_city] = line[3]
      market_hash[:market_county] = line[4]
      market_hash[:market_state] = line[5]
      market = FarMar::Market.new(market_hash)
      all_market_instances << market
    end

    all_market_instances

  end

  def self.find(id)
    raise ArgumentError, "Market ID must be numeric" if id =~ /[[:alpha][:punct:][:blank:]]/
    all.each do |market|
      if market.market_id == id.to_i
        return market
      end
    end
    raise ArgumentError, "Market ID not found"
  end

  def vendors
    vendor_of_market_array = []
    all_vendors = FarMar::Vendor.all
    all_vendors.each do |vendor|
      if vendor.market_id == @market_id
        vendor_of_market_array << vendor
      end
    end
    vendor_of_market_array
  end

  #products returns a collection of FarMar::Product instances that are associated to the market through the FarMar::Vendor class.
  def products
    all_vendors = FarMar::Vendor.all
    associated_products = []

    all_vendors.each do |vendor|
      if vendor.market_id == @market_id
        associated_products << vendor.products
      end
    end

    if associated_products.flatten == nil
      associated_products.uniq!
    else
      associated_products.flatten!.uniq!
    end

    return associated_products
  end

  #self.search(search_term) returns a collection of FarMar::Market instances where the market name or vendor name contain the search_term. For example FarMar::Market.search('school') would return 3 results, one being the market with id 75 (Fox School Farmers FarMar::Market).
  def self.search(search_term)
    search_result_markets = []
    all.each do |market|
      market_string = "#{market.market_id} #{market.market_name} #{market.market_address} #{market.market_city} #{market.market_county} #{market.market_state} #{market.market_zip}".gsub(/[[:punct:]]/, " ").downcase
      if market_string.include? search_term
        search_result_markets << market
      end
    end

    if search_result_markets.length == 0
      raise ArgumentError, "No markets match that search term"
    else
      return search_result_markets
    end
  end

  #prefered_vendor: returns the vendor with the highest revenue
  def prefered_vendor(date = nil)
    highest_revenue = 0
    highest_revenue_vendor = nil
    vendors.each do |vendor|
      revenue = vendor.revenue(date)
      if revenue > highest_revenue
        highest_revenue = revenue
        highest_revenue_vendor = vendor
      end
    end

    highest_revenue_vendor

  end

  #worst_vendor: returns the vendor with the lowest revenue
  def worst_vendor(date = nil)
    lowest_revenue = 1000000000000
    lowest_revenue_vendor = nil
    vendors.each do |vendor|
      revenue = vendor.revenue(date)
      if revenue < lowest_revenue
        lowest_revenue = revenue
        lowest_revenue_vendor = vendor
      end
    end

    lowest_revenue_vendor
    
  end

end
