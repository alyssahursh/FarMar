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

  it 'Elements of self.all is an instance of the class FarMar::Product' do
    products.each do |product|
      expect(product.class).must_equal(FarMar::Product)
    end
  end

  it 'self.find(id) method returns instance of the class FarMar::Market with correct ID' do
    random_number = rand(length)
    found_product = FarMar::Product.find(random_number)
    expect(found_product.class).must_equal(FarMar::Product)
    expect(found_product.product_id).must_equal(random_number)
  end

  it 'self.find(id) raises argument error for non-numeric input' do
    expect( proc {FarMar::Product.find("A String!")}).must_raise(ArgumentError)
  end

  it 'self.find(id) raises argument error if ID does not exist' do
    expect( proc {FarMar::Product.find(12345678901234567890)}).must_raise(ArgumentError)
  end

  it '.vendor returns a FarMar::Vendor instance' do
    vendor = products[rand(length)].vendor
    expect(vendor.class).must_equal(FarMar::Vendor)
  end

  it '.vendor returns the vendor with the correct vendor id' do
    product = products[rand(length)]
    vendor = product.vendor
    expect(vendor.vendor_id).must_equal(product.vendor_id)
  end

  it '.sales returns an array' do
    product = products[rand(length)]
    sales = product.sales
    expect(sales.class).must_equal(Array)
  end

  it '.sales returns an array containing FarMar:Sale instances' do
    product = products[5]
    sales = product.sales
    sales.each do |sale|
      expect(sale.class).must_equal(FarMar::Sale)
    end
  end

  it '.sales returns sales with the correct product id' do
    product = products[72]
    sales = product.sales
    sales.each do |sale|
      expect(sale.product_id).must_equal(product.product_id)
    end
  end

  it '.number_of_sales returns an integer' do
    product = products[rand(length)]
    expect(product.number_of_sales.class).must_equal(Fixnum)
  end

  it '.number_of_sales returns the correct number of times the product has been sold' do
    product = products[125]
    sale_list = FarMar::Sale.all
    num_sales = 0
    sale_list.each do |sale|
      if sale.product_id == product.product_id
        num_sales += 1
      end
    end
    expect(product.number_of_sales).must_equal(num_sales)
  end

  it 'self.by_vendor(vendor_id) returns an array' do
    all_vendors = FarMar::Vendor.all
    by_vendor = FarMar::Product.by_vendor(264)
    expect(by_vendor.class).must_equal(Array)
  end

  it 'the elements in the self.by_vendor(vendor_id) array are instances of the FarMar::Product class' do
    all_vendors = FarMar::Vendor.all
    random_vendor = all_vendors[264]
    by_vendor = FarMar::Product.by_vendor(random_vendor.vendor_id)
    by_vendor.each do |product|
      expect(product.class).must_equal(FarMar::Product)
    end
  end

  it 'the elements in the self.by_vendor(vendor_id) array have the correct vendor_id' do
    all_vendors = FarMar::Vendor.all
    random_vendor = all_vendors[264]
    by_vendor = FarMar::Product.by_vendor(random_vendor.vendor_id)
    by_vendor.each do |product|
      expect(product.vendor_id).must_equal(random_vendor.vendor_id)
    end
  end

  # Check for duplicates

end
