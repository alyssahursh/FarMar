# far_mar_sale.rb

require_relative '../far_mar.rb'
# require_relative '../support/sales.csv'


# Each sale belongs to a sale __AND__ a product. The `sale_id` and `product_id` fields refer to the `FarMar::Sale` and `FarMar::Product` ID fields, respectively. The `FarMar::Sale` data, in order in the CSV, consists of:
#
# 1. ID - (Fixnum) uniquely identifies the sale
# 2. Amount - (Fixnum) the amount of the transaction, in cents (i.e., 150 would be $1.50)
# 3. Purchase_time - (Datetime) when the sale was completed
# 4. Sale_id - (Fixnum) a reference to which sale completed the sale
# 5. Product_id - (Fixnum) a reference to which product was sold

class FarMar::Sale

  attr_reader :sale_id

  def initialize(sale_hash)
    @sale_id = sale_hash[:sale_id] # (Fixnum) a unique identifier for that sale
    @sale_amount = sale_hash[:sale_amount] # (Fixnum) the amount of the transaction, in cents (i.e., 150 would be $1.50)
    @sale_purchase_time = sale_hash[:sale_purchase_time] # (Datetime) when the sale was completed
    @sale_market_id = sale_hash[:sale_market_id] # (Fixnum) a reference to which sale completed the sale
    @sale_product_id = sale_hash[:sale_product_id] # (Fixnum) a reference to which product was sold
  end

  def self.all

    all_sale_instances = []

    CSV.open('/Users/alyssa/ada/Week5/FarMar/support/sales.csv', 'r').each do |line|
      sale_hash = {}
      sale_hash[:sale_id] = line[0].to_i
      sale_hash[:sale_amount] = line[1].to_i
      sale_hash[:sale_purchase_time] = line[2]
      sale_hash[:sale_market_id] = line[3].to_i
      sale_hash[:sale_product_id] = line[4].to_i
      sale = FarMar::Sale.new(sale_hash)
      all_sale_instances << sale
    end

    return all_sale_instances

  end

  def self.find(id)
    array = all
    array.each do |sale|
      if sale.sale_id == id
        return sale
        break
      end
    end
  end


end
