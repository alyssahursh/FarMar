# sale_spec.rb

require_relative 'spec_helper.rb'

require_relative '../lib/far_mar_sale.rb'

require 'date'


describe 'Test Sale' do

  let(:sales) { FarMar::Sale.all }
  let(:length) { CSV.read('/Users/alyssa/ada/Week5/FarMar/support/sales.csv').length }

  it 'self.all method returns an object of class Array' do
    expect(sales.class).must_equal(Array)
  end

  it 'self.all Array contains the same number of elements as the length of the original CSV' do
    expect(sales.length).must_equal(length)
  end

  it 'A random element of self.all is an instance of the class FarMar::Sale' do
    sales.each do |sale|
      expect(sale.class).must_equal(FarMar::Sale)
    end
  end

  it 'self.find(id) raises argument error for non-numeric input' do
    expect( proc {FarMar::Sale.find("A String!")}).must_raise(ArgumentError)
  end

  it 'self.find(id) raises argument error if ID does not exist' do
    expect( proc {FarMar::Sale.find(12345678901234567890)}).must_raise(ArgumentError)
  end

  it 'self.find(id) method returns instance of the class FarMar::Market with correct ID' do
    random_number = rand(length)
    found_sale = FarMar::Sale.find(random_number)
    expect(found_sale.class).must_equal(FarMar::Sale)
    expect(found_sale.sale_id).must_equal(random_number)
  end

  it '.vendor returns a FarMar::Vendor instance' do
    random_sale = sales[rand(length)]
    vendor = random_sale.vendor
    expect(vendor.class).must_equal(FarMar::Vendor)
  end

  it '.vendor returns an instance with the correct vendor_id' do
    random_sale = sales[rand(length)]
    vendor = random_sale.vendor
    expect(vendor.vendor_id).must_equal(random_sale.vendor_id)
  end

  it '.product returns a FarMar::Product instance' do
    random_sale = sales[rand(length)]
    product = random_sale.product
    expect(product.class).must_equal(FarMar::Product)
  end

  it '.product returns an instance with the correct product_id' do
    random_sale = sales[rand(length)]
    product = random_sale.product
    expect(product.product_id).must_equal(random_sale.product_id)
  end


  it 'self.between(beginning_time, end_time) returns an array' do
    date1 = DateTime.new(2013, 11, rand(1..10))
    date2 = DateTime.new(2013, 11, rand(20..30))

    expect(FarMar::Sale.between(date1, date2).class).must_equal(Array)
  end

  it 'elements of the self.between(beginning_time, end_time) array are instances of FarMar::Sale' do
    date1 = DateTime.new(2013, 11, 1)
    date2 = DateTime.new(2013, 11, 30)

    certain_sales = FarMar::Sale.between(date1, date2)
    certain_sales.each do |specific_sale|
      expect(specific_sale.class).must_equal(FarMar::Sale)
    end
  end

  it 'elements of the self.between(beginning_time, end_time) array are between the beginning_time and end_time inputs' do
    date1 = DateTime.new(2013, 11, 1)
    date2 = DateTime.new(2013, 11, 30)

    certain_sales = FarMar::Sale.between(date1, date2)
    certain_sales.each do |specific_sale|
      expect(specific_sale.purchase_time >= date1).must_equal(true)
      expect(specific_sale.purchase_time <= date2).must_equal(true)
    end
  end

  it 'elements of the self.between(beginning_time, end_time) array are after the beginning_time' do
    date2 = DateTime.new(2013, 11, 1)
    date1 = DateTime.new(2013, 11, 30)

    certain_sales = FarMar::Sale.between(date1, date2)
    certain_sales.each do |specific_sale|
      expect(specific_sale.purchase_time <= date1).must_equal(true)
    end
  end

  it 'elements of the self.between(beginning_time, end_time) array are before the end_time' do
    date2 = DateTime.new(2013, 11, 1)
    date1 = DateTime.new(2013, 11, 30)

    certain_sales = FarMar::Sale.between(date1, date2)
    certain_sales.each do |specific_sale|
      expect(specific_sale.purchase_time >= date2).must_equal(true)
    end
  end

  it 'elements of the self.between(beginning_time, end_time) array are between the beginning_time and end_time inputs' do
    date1 = DateTime.new(2010, 11, rand(1..10))
    date2 = DateTime.new(2010, 11, rand(20..30))

    certain_sales = FarMar::Sale.between(date1, date2)
    expect(certain_sales.length).must_equal(0)
  end

end
