# product_spec.rb

require_relative 'spec_helper.rb'

require_relative '../lib/far_mar_product.rb'

describe 'Test Product' do

  let(:products) { FarMar::Product.all }
  let(:length) { CSV.read('/Users/alyssa/ada/Week5/FarMar/support/products.csv').length }

  it 'self.all method returns an object of class Array' do
    expect(products.class).must_equal(Array)
  end

  it 'self.all Array contains the same number of elements as the length of the original CSV' do
    expect(products.length).must_equal(length)
  end

  it 'A random element of self.all is an instance of the class FarMar::Product' do
    expect(products[rand(length)].class).must_equal(FarMar::Product)
  end

  it 'self.find(id) method returns instance of the class FarMar::Market with correct ID' do
    random_number = rand(length)
    found_product = FarMar::Product.find(random_number)
    expect(found_product.class).must_equal(FarMar::Product)
    expect(found_product.product_id).must_equal(random_number)
  end

  it '.vendor returns a vendor instance' do
    vendor = products[rand(length)].vendor
    expect(vendor.class).must_equal(FarMar::Vendor)
  end

  it '.vendor returns the vendor with the correct vendor id' do
    product = products[rand(length)]
    vendor = product.vendor
    expect(vendor.vendor_id).must_equal(product.vendor_id)
  end




  # sales: returns a collection of FarMar::Sale instances that are associated using the FarMar::Sale product_id field.
  def sales
  end

  # number_of_sales: returns the number of times this product has been sold.
  def number_of_sales
  end

  # self.by_vendor(vendor_id): returns all of the products with the given vendor_id
  def self.by_vendor(vendor_id)
  end

end
