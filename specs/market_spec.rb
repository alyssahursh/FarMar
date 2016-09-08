# market_spec.rb

require_relative 'spec_helper.rb'

require_relative '../lib/far_mar_market.rb'


describe 'Test Market' do

  let(:markets) { FarMar::Market.all }
  let(:market_array_length) { CSV.read('/Users/alyssa/ada/Week5/FarMar/support/markets.csv').length }
  let(:rand_num) { rand(market_array_length) }
  let(:random_market) { markets[rand_num] }
  let(:market_vendor) { random_market.vendors }
  let(:found_market) { FarMar::Market.find(rand_num) }


  it 'self.all method returns an object of class Array' do
    expect(markets.class).must_equal(Array)
  end

  it 'self.all Array contains the same number of elements as the length of the original CSV' do
    expect(markets.length).must_equal(market_array_length)
  end

  it 'Elements of self.all is an instance of the class FarMar::Market' do
    markets.each do |market|
      expect(market.class).must_equal(FarMar::Market)
    end
  end

  it 'self.find(id) method returns instance of the class FarMar::Market' do
    expect(found_market.class).must_equal(FarMar::Market)
  end

  it 'self.find(id) method returns market with the correct ID' do
    expect(found_market.market_id).must_equal(rand_num)
  end


  it 'self.find(id) raises argument error for non-numeric input' do
    expect( proc {FarMar::Market.find("A String!")}).must_raise(ArgumentError)
  end

  it 'self.find(id) raises argument error if ID does not exist' do
    expect( proc {FarMar::Market.find(12345678901234567890)}).must_raise(ArgumentError)
  end

  it '.vendors should return a array' do
    expect(random_market.vendors.class).must_equal(Array)
  end

  it 'Elements inside .vendors array should be a member FarMar::Vendor' do
    market_vendor.each do |vendor|
      expect(vendor.class).must_equal(FarMar::Vendor)
    end
  end

  it 'Elements inside .vendors array should have correct market id' do
    market_vendor.each do |vendor|
      expect(vendor.market_id).must_equal(random_market.market_id)
    end
  end

  # if 'self.all does not allow duplicates' do
  #   expect(markets.uniq.length).must_equal(markets.length)
  # end

end
