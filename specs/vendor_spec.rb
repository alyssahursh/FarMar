# vendor_spec.rb

require_relative 'spec_helper.rb'

require_relative '../lib/far_mar_vendor.rb'

describe 'Test Vendor' do

  let(:vendors) { FarMar::Vendor.all }
  let(:length) { CSV.read('/Users/alyssa/ada/Week5/FarMar/support/vendors.csv').length }

  it 'self.all method returns an object of class Array' do
    expect(vendors.class).must_equal(Array)
  end

  it 'self.all Array contains the same number of elements as the length of the original CSV' do
    expect(vendors.length).must_equal(length)
  end

  it 'Elements of self.all is an instance of the class FarMar::Vendor' do
    vendors.each do |vendor|
      expect(vendor.class).must_equal(FarMar::Vendor)
    end
  end

  it 'self.find(id) method returns instance of the class FarMar::Market with correct ID' do
    random_number = rand(length)
    found_vendor = FarMar::Vendor.find(random_number)
    expect(found_vendor.class).must_equal(FarMar::Vendor)
    expect(found_vendor.vendor_id).must_equal(random_number)
  end

  it 'self.find(id) raises argument error for non-numeric input' do
    expect( proc {FarMar::Vendor.find("A String!")}).must_raise(ArgumentError)
  end

  it 'self.find(id) raises argument error if ID does not exist' do
    expect( proc {FarMar::Vendor.find(12345678901234567890)}).must_raise(ArgumentError)
  end

  it '.market returns a FarMar::Market instance' do
    vendor = vendors[rand(length)]
    market = vendor.market
    expect(market.class).must_equal(FarMar::Market)
  end

  it '.market returns the instance with the correct market_id field' do
    vendor = vendors[rand(length)]
    market = vendor.market
    expect(market.market_id).must_equal(vendor.market_id)
  end

  it '.products returns an Array' do
    vendor = vendors[rand(length)]
    products = vendor.products
    expect(products.class).must_equal(Array)
  end

  it 'the elements in the .products array are FarMar:Product instances' do
    vendor = vendors[rand(length)]
    products = vendor.products
    products.each do |product|
      expect(product.class).must_equal(FarMar::Product)
    end
  end

  it 'the instances in the .products array have the correct vendor_id number' do
    vendor = vendors[rand(length)]
    products = vendor.products
    products.each do |product|
      expect(product.vendor_id).must_equal(vendor.vendor_id)
    end
  end

  it '.sales returns an array' do
    vendor = vendors[rand(length)]
    sales = vendor.sales
    expect(sales.class).must_equal(Array)
  end

  it 'the elements in the .sales array are FarMar::Sale instances' do
    vendor = vendors[rand(length)]
    sales = vendor.sales
    sales.each do |sale|
      expect(sale.class).must_equal(FarMar::Sale)
    end
  end

  it 'the instances in the .sales array have the correct vendor_id number' do
    vendor = vendors[rand(length)]
    sales = vendor.sales
    sales.each do |sale|
      expect(sale.vendor_id).must_equal(vendor.vendor_id)
    end
  end

  it '.revenue returns an integer' do
    vendor = vendors[rand(length)]
    revenue = vendor.revenue
    expect(revenue.class).must_equal(Fixnum)
  end

  it '.revenue returns the correct sum' do
    vendor = vendors[rand(length)]
    revenue_total = 0
    all_sales = FarMar::Sale.all
    all_sales.each do |sale|
      if sale.vendor_id == vendor.vendor_id
        revenue_total += sale.sale_amount
      end
    end
    expect(vendor.revenue).must_equal(revenue_total)

  end

  it 'self.by_market(market_id) returns an array' do
    all_markets = FarMar::Market.all
    random_market = all_markets[rand(all_markets.length)]
    vendor_array = FarMar::Vendor.by_market(random_market.market_id)
    expect(vendor_array.class).must_equal(Array)
  end

  it 'the elements of self.by_market(market_id) array are instances of FarMar:Vendor' do
    all_markets = FarMar::Market.all
    random_market = all_markets[rand(all_markets.length)]
    vendor_array = FarMar::Vendor.by_market(random_market.market_id)
    vendor_array.each do |vendor|
      expect(vendor.class).must_equal(FarMar::Vendor)
    end
  end

  it 'the elements of self.by_market(market_id) array have the correct vendor_id' do
    all_markets = FarMar::Market.all
    random_market = all_markets[rand(all_markets.length)]
    vendor_array = FarMar::Vendor.by_market(random_market.market_id)
    vendor_array.each do |vendor|
      expect(vendor.market_id).must_equal(random_market.market_id)
    end
  end

end
