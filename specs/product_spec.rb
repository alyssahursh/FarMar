# product_spec.rb

require_relative 'spec_helper.rb'

require_relative '../lib/far_mar_product.rb'

describe 'Test Product' do

  let(:products) { FarMar::Product.all }
  let(:product_array_length) { CSV.read('/Users/alyssa/ada/Week5/FarMar/support/products.csv').length }
  let(:rand_num) { rand(product_array_length) }
  let(:random_product) { products[rand_num] }
  let(:product_vendor) { random_product.vendor }
  let(:found_product) { FarMar::Product.find(rand_num) }
  let(:all_vendors) { FarMar::Vendor.all }
  let(:sale_list) { FarMar::Sale.all }
  let(:random_product_sales) { random_product.sales }
  let(:by_vendor) { FarMar::Product.by_vendor(product_vendor.vendor_id) }



  it 'self.all method returns an object of class Array' do
    expect(products.class).must_equal(Array)
  end

  it 'self.all Array contains the same number of elements as the length of the original CSV' do
    expect(products.length).must_equal(product_array_length)
  end

  it 'Elements of self.all is an instance of the class FarMar::Product' do
    products.each do |product|
      expect(product.class).must_equal(FarMar::Product)
    end
  end

  it 'self.find(id) method returns instance of the class FarMar::Market' do
    expect(found_product.class).must_equal(FarMar::Product)
  end

  it 'self.find(id) method returns market with the correct ID' do
    expect(found_product.product_id).must_equal(rand_num)
  end

  it 'self.find(id) raises argument error for non-numeric input' do
    expect( proc {FarMar::Product.find("A String!")}).must_raise(ArgumentError)
  end

  it 'self.find(id) raises argument error if ID does not exist' do
    expect( proc {FarMar::Product.find(12345678901234567890)}).must_raise(ArgumentError)
  end

  it '.vendor returns a FarMar::Vendor instance' do
    expect(product_vendor.class).must_equal(FarMar::Vendor)
  end

  it '.vendor returns the vendor with the correct vendor id' do
    expect(product_vendor.vendor_id).must_equal(random_product.vendor_id)
  end

  it '.sales returns an array' do
    expect(random_product_sales.class).must_equal(Array)
  end

  it '.sales returns an array containing FarMar:Sale instances' do
    random_product_sales.each do |sale|
      expect(sale.class).must_equal(FarMar::Sale)
    end
  end

  it '.sales returns sales with the correct product id' do
    random_product_sales.each do |sale|
      expect(sale.product_id).must_equal(random_product.product_id)
    end
  end

  it '.number_of_sales returns an integer' do
    expect(random_product.number_of_sales.class).must_equal(Fixnum)
  end

  it '.number_of_sales returns the correct number of times the product has been sold' do
    num_sales = 0
    sale_list.each do |sale|
      if sale.product_id == random_product.product_id
        num_sales += 1
      end
    end
    expect(random_product.number_of_sales).must_equal(num_sales)
  end

  it 'self.by_vendor(vendor_id) returns an array' do
    expect(by_vendor.class).must_equal(Array)
  end

  it 'the elements in the self.by_vendor(vendor_id) array are instances of the FarMar::Product class' do
    by_vendor.each do |product|
      expect(product.class).must_equal(FarMar::Product)
    end
  end

  it 'the elements in the self.by_vendor(vendor_id) array have the correct vendor_id' do
    by_vendor.each do |product|
      expect(product.vendor_id).must_equal(product_vendor.vendor_id)
    end
  end

  # Check for duplicates

end
