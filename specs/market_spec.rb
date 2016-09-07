# market_spec.rb

require_relative 'spec_helper.rb'

require_relative '../lib/far_mar_market.rb'


describe 'Test Market' do

  let(:markets) { FarMar::Market.all }
  let(:length) { CSV.read('/Users/alyssa/ada/Week5/FarMar/support/markets.csv').length }
  
  it 'self.all method returns an object of class Array' do
    expect(markets.class).must_equal(Array)
  end

  it 'self.all Array contains the same number of elements as the length of the original CSV' do
    expect(markets.length).must_equal(length)
  end

  it 'A random element of self.all is an instance of the class FarMar::Market' do
    expect(markets[rand(length)].class).must_equal(FarMar::Market)
  end

  it 'self.find(id) method returns instance of the class FarMar::Market with correct ID' do
    random_number = rand(length).to_i
    found_market = FarMar::Market.find(random_number)
    expect(found_market.class).must_equal(FarMar::Market)
    expect(found_market.market_id).must_equal(random_number)
  end

  it '.vendors should return a array' do
    expect(markets[rand(length)].vendors.class).must_equal(Array)
  end


  it 'Elements inside .vendors array should be a member FarMar::Vendor' do
    vendors = markets[rand(length)].vendors
    expect(vendors[rand(vendors.length)].class).must_equal(FarMar::Vendor)
  end

end
