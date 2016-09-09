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
  let(:some_products) { random_market.products }
  let(:search_school) { FarMar::Market.search('school') }


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

  it '.products returns an array' do
    expect(some_products.class).must_equal(Array)
  end

  it '.products returns an instance of FarMar:Product' do
    some_products.each do |product|
      expect(product.class).must_equal(FarMar::Product)
    end
  end

  it '.products returns products whose vendor is present at this market' do
    vendor_id_array = []
    market_vendor.each do |vendor|
      vendor_id_array << vendor.vendor_id
    end

    some_products.each do |product|
      expect(vendor_id_array).must_include(product.vendor_id)
    end
  end

  it 'self.search(search_term) returns an array' do
    expect(search_school.class).must_equal(Array)
  end

  it 'Elements of the self.search(search_term) array are FarMar::Market' do
    search_school.each do |search_result|
      expect(search_result.class).must_equal(FarMar::Market)
    end
  end

  it 'Elements of the self.search(search_term) array contain the search term' do
    search_school.each do |search_result|
      search_result_string = "#{search_result.market_id} #{search_result.market_name} #{search_result.market_address} #{search_result.market_city} #{search_result.market_county} #{search_result.market_state} #{search_result.market_zip}".gsub(/[[:punct:]]/, " ").downcase
      expect(search_result_string).must_include('school')
    end
  end


  # if 'self.all does not allow duplicates' do
  #   expect(markets.uniq.length).must_equal(markets.length)
  # end

end
