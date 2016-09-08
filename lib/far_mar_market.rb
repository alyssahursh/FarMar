# far_mar_market.rb

require_relative '../far_mar.rb'
# require_relative '../support/markets.csv'

# 1. ID - (Fixnum) a unique identifier for that market
# 2. Name - (String) the name of the market (not guaranteed unique)
# 3. Address - (String) street address of the market
# 4. City - (String) city in which the market is located
# 5. County - (String) county in which the market is located
# 6. State - (String) state in which the market is located
# 7. Zip - (String) zipcode in which the market is located

class FarMar::Market

  attr_reader :market_id

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

    array = all
    array.each do |market|
      if market.market_id == id.to_i
        return market
      end
    end
    raise ArgumentError, "Market ID not found"
  end

  def vendors

    complete_vendor_array = FarMar::Vendor.all
    vendor_of_market_array = []

    complete_vendor_array.each do |vendor|
      if vendor.market_id == @market_id
        vendor_of_market_array << vendor
      end
    end

    vendor_of_market_array

  end

end
