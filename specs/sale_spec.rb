# sale_spec.rb

require_relative 'spec_helper.rb'

require_relative '../lib/far_mar_sale.rb'
require 'awesome_print'


describe 'Test Sale' do

  before 'Import CSV to FarMar::Sale' do
    @sales = FarMar::Sale.all
    @length = CSV.read('/Users/alyssa/ada/Week5/FarMar/support/sales.csv').length
  end

  it 'self.all method returns an object of class Array' do
    expect(@sales.class).must_equal(Array)
  end

  it 'self.all Array contains the same number of elements as the length of the original CSV' do
    expect(@sales.length).must_equal(@length)
  end

  it 'A random element of self.all is an instance of the class FarMar::Sale' do
    expect(@sales[rand(@length)].class).must_equal(FarMar::Sale)
  end

  it 'self.find(id) method returns instance of the class FarMar::Market with correct ID' do
    random_number = rand(@length)
    found_sale = FarMar::Sale.find(random_number)
    expect(found_sale.class).must_equal(FarMar::Sale)
    expect(found_sale.sale_id).must_equal(random_number)
  end

end
