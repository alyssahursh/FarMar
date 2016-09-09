# vendor_spec.rb

require_relative 'spec_helper.rb'

require_relative '../lib/far_mar_vendor.rb'

describe 'Test Vendor' do

  let(:vendors) { FarMar::Vendor.all }
  let(:vendor_array_length) { CSV.read('/Users/alyssa/ada/Week5/FarMar/support/vendors.csv').length }
  let(:rand_num) { rand(vendor_array_length) }
  let(:random_vendor) { vendors[rand_num] }
  let(:found_vendor) { FarMar::Vendor.find(rand_num)}
  let(:random_vendor_market) { random_vendor.market }
  let(:random_vendor_products) { random_vendor.products }
  let(:random_vendor_sales) { random_vendor.sales }
  let(:random_vendor_revenue) { random_vendor.revenue }
  let(:sale_list) { FarMar::Sale.all }
  let(:vendor_array) { FarMar::Vendor.by_market(random_vendor_market.market_id) }

  it 'self.all method returns an object of class Array' do
    expect(vendors.class).must_equal(Array)
  end

  it 'self.all Array contains the same number of elements as the length of the original CSV' do
    expect(vendors.length).must_equal(vendor_array_length)
  end

  it 'Elements of self.all is an instance of the class FarMar::Vendor' do
    vendors.each do |vendor|
      expect(vendor.class).must_equal(FarMar::Vendor)
    end
  end

  it 'self.find(id) method returns instance of the class FarMar::Market' do
    expect(found_vendor.class).must_equal(FarMar::Vendor)
  end

  it 'self.find(id) method returns instance of the class FarMar::Market' do
    expect(found_vendor.vendor_id).must_equal(rand_num)
  end

  it 'self.find(id) raises argument error for non-numeric input' do
    expect( proc {FarMar::Vendor.find("A String!")}).must_raise(ArgumentError)
  end

  it 'self.find(id) raises argument error if ID does not exist' do
    expect( proc {FarMar::Vendor.find(12345678901234567890)}).must_raise(ArgumentError)
  end

  it '.market returns a FarMar::Market instance' do
    expect(random_vendor_market.class).must_equal(FarMar::Market)
  end

  it '.market returns the instance with the correct market_id field' do
    expect(random_vendor_market.market_id).must_equal(random_vendor.market_id)
  end

  it '.products returns an Array' do
    expect(random_vendor_products.class).must_equal(Array)
  end

  it 'the elements in the .products array are FarMar:Product instances' do
    random_vendor_products.each do |product|
      expect(product.class).must_equal(FarMar::Product)
    end
  end

  it 'the instances in the .products array have the correct vendor_id number' do
    random_vendor_products.each do |product|
      expect(product.vendor_id).must_equal(random_vendor.vendor_id)
    end
  end

  it '.sales returns an array' do
    expect(random_vendor_sales.class).must_equal(Array)
  end

  it 'the elements in the .sales array are FarMar::Sale instances' do
    random_vendor_sales.each do |sale|
      expect(sale.class).must_equal(FarMar::Sale)
    end
  end

  it 'the instances in the .sales array have the correct vendor_id number' do
    random_vendor_sales.each do |sale|
      expect(sale.vendor_id).must_equal(random_vendor.vendor_id)
    end
  end

  it '.revenue returns an integer' do
    expect(random_vendor_revenue.class).must_equal(Fixnum)
  end

  it '.revenue returns the correct sum' do
    revenue_total = 0
    sale_list.each do |sale|
      if sale.vendor_id == random_vendor.vendor_id
        revenue_total += sale.sale_amount
      end
    end
    expect(random_vendor.revenue).must_equal(revenue_total)
  end

  it 'self.by_market(market_id) returns an array' do
    expect(vendor_array.class).must_equal(Array)
  end

  it 'the elements of self.by_market(market_id) array are instances of FarMar:Vendor' do
    vendor_array.each do |vendor|
      expect(vendor.class).must_equal(FarMar::Vendor)
    end
  end

  it 'the elements of self.by_market(market_id) array have the correct market_id' do
    vendor_array.each do |vendor|
      expect(vendor.market_id).must_equal(random_vendor_market.market_id)
    end
  end

end
