# far_mar_sale.rb

require_relative '../far_mar.rb'
# 
# Each sale belongs to a vendor __AND__ a product. The `vendor_id` and `product_id` fields refer to the `FarMar::Vendor` and `FarMar::Product` ID fields, respectively. The `FarMar::Sale` data, in order in the CSV, consists of:
#
# 1. ID - (Fixnum) uniquely identifies the sale
# 2. Amount - (Fixnum) the amount of the transaction, in cents (i.e., 150 would be $1.50)
# 3. Purchase_time - (Datetime) when the sale was completed
# 4. Vendor_id - (Fixnum) a reference to which vendor completed the sale
# 5. Product_id - (Fixnum) a reference to which product was sold

class FarMar::Sale

end
