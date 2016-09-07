# vendor_spec.rb

require_relative 'spec_helper.rb'

require_relative '../lib/far_mar_vendor.rb'

describe 'Test Vendor' do

  before 'Import CSV to FarMar::Vendor' do
    @vendors = FarMar::Vendor.all
    @length = CSV.read('/Users/alyssa/ada/Week5/FarMar/support/vendors.csv').length
  end

  it 'self.all method returns an object of class Array' do
    expect(@vendors.class).must_equal(Array)
  end

  it 'self.all Array contains the same number of elements as the length of the original CSV' do
    expect(@vendors.length).must_equal(@length)
  end

  it 'A random element of self.all is an instance of the class FarMar::Vendor' do
    expect(@vendors[rand(@length)].class).must_equal(FarMar::Vendor)
  end

  it 'self.find(id) method returns instance of the class FarMar::Market with correct ID' do
    random_number = rand(@length)
    found_vendor = FarMar::Vendor.find(random_number)
    expect(found_vendor.class).must_equal(FarMar::Vendor)
    expect(found_vendor.vendor_id).must_equal(random_number)
  end

end
