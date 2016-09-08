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
    expect(sales[rand(length)].class).must_equal(FarMar::Sale)
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
    date1 = Time.new(2013, rand(11), rand(1..14))
    date2 = Time.new(2013, rand(11), rand(15..28))

    if date1 > date2
      date1, date2 = date2, date1
    end

    expect(FarMar::Sale.between(date1, date2).class).must_equal(Array)
  end

  it 'elements of the self.between(beginning_time, end_time) array are instances of FarMar::Sale' do
    date1 = Time.new(2013, rand(11), rand(1..14))
    date2 = Time.new(2013, rand(11), rand(15..28))

    if date1 > date2
      date1, date2 = date2, date1
    end

    certain_sales = FarMar::Sale.between(date1, date2)
    certain_sales.each do |sale|
      except(sale.class).must_equal(FarMar::Sale)
    end
  end

  it 'elements of the self.between(beginning_time, end_time) array are between the beginning_time and end_time inputs' do
    date1 = Time.new(2013, rand(11), rand(1..14))
    date2 = Time.new(2013, rand(11), rand(15..28))

    if date1 > date2
      date1, date2 = date2, date1
    end

    certain_sales = FarMar::Sale.between(date1, date2)
    certain_sales.each do |sale|
      expect(sale.purchase_time >= date1).must_equal(true)
      expect(sale.purchase_time <= date2).must_equal(true)
    end
  end


end
