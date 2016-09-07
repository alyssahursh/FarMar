# far_mar_vendor.rb

require_relative '../far_mar.rb'
# require_relative '../support/vendors.csv'

#
# 1. ID - (Fixnum) uniquely identifies the vendor
# 2. Name - (String) the name of the vendor (not guaranteed unique)
# 3. No. of Employees - (Fixnum) How many employees the vendor has at the market
# 4. Market_id - (Fixnum) a reference to which market the vendor attends

class FarMar::Vendor

  attr_reader :vendor_id, :vendor_market_id

  def initialize(vendor_hash)
    @vendor_id = vendor_hash[:vendor_id] # (Fixnum) a unique identifier for that vendor
    @vendor_name = vendor_hash[:vendor_name] # (String) the name of the vendor (not guaranteed unique)
    @vendor_num_employees = vendor_hash[:vendor_num_employees] # (Fixnum) How many employees the vendor has at the market
    @vendor_market_id = vendor_hash[:vendor_market_id] # (Fixnum) a reference to which market the vendor attends
  end

  def self.all

    all_vendor_instances = []

    CSV.open('/Users/alyssa/ada/Week5/FarMar/support/vendors.csv', 'r').each do |line|
      vendor_hash = {}
      vendor_hash[:vendor_id] = line[0].to_i
      vendor_hash[:vendor_name] = line[1]
      vendor_hash[:vendor_num_employees] = line[2]
      vendor_hash[:vendor_market_id] = line[3].to_i
      vendor = FarMar::Vendor.new(vendor_hash)
      all_vendor_instances << vendor
    end

    return all_vendor_instances

  end


  def self.find(id)
    array = all
    array.each do |vendor|
      if vendor.vendor_id == id
        return vendor
        break
      end
    end
  end


end
