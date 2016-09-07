# product_spec.rb

require_relative 'spec_helper.rb'

require_relative '../lib/far_mar_product.rb'

describe 'Test Product' do

  before 'Import CSV to FarMar::Product' do
    @products = FarMar::Product.all
    @length = CSV.read('/Users/alyssa/ada/Week5/FarMar/support/products.csv').length
  end

  it 'self.all method returns an object of class Array' do
    expect(@products.class).must_equal(Array)
  end

  it 'self.all Array contains the same number of elements as the length of the original CSV' do
    expect(@products.length).must_equal(@length)
  end

  it 'A random element of self.all is an instance of the class FarMar::Product' do
    expect(@products[rand(@length)].class).must_equal(FarMar::Product)
  end

  it 'self.find(id) method returns instance of the class FarMar::Market with correct ID' do
    random_number = rand(@length)
    found_product = FarMar::Product.find(random_number)
    expect(found_product.class).must_equal(FarMar::Product)
    expect(found_product.product_id).must_equal(random_number)
  end

end
