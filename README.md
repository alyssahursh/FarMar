# FarMar
This was one of our earliest Ruby applications. We were asked to create a small application that could read in a CSV file to seed a database and give users a way to interact with the CSV data.

## FarMar: The Farmers' Market Finder
In this assignment we will be creating an application to look up farmers markets and their related vendors, products, and sales. We will use __CSV__ files as our _database_.

### Learning Goals
- Reinforce and practice all of the Ruby and programming concepts we've covered in class
  - Practice writing specs and using TDD
  - Practice working with raw data and using it to create _instances_ of a Ruby class
  - Practice using _Enumerable_ methods to work with collections of data or _instances_
  - Practice organizing and working with multiple files in a single project.

### Project Setup and Expectations
#### Project Structure
Create a Ruby class to represent each kind of data in the `support/` directory. In the __Product Data__ section, there are detailed descriptions of each _csv_ file contents and its relation to other objects in the system. Your implementation will have _class methods_ to handle finding, sorting, and collecting the data into _instances_ representing individual rows of data. Each of those _instances_ will have _instance methods_ to provide details about the object.

##### Encapsulation
To manage our data classes we will use a file named `/far_mar.rb`. It should look something like:

```ruby
# gems your project needs
require 'csv'

# our namespace module
module FarMar; end

# all of our data classes that live in the module
require 'lib/farmar_market'
# ...require all needed classes
```

Each _class_ you build will live in the `/lib` directory, and belong to the `FarMar` _module_:

```ruby
# lib/farmar_market.rb
class FarMar::Market
  # Your code goes here
end
```

The module provides a _namespace_ for the application. A _namespace_ ensures the _classes_ we create will not 'collide' or 'overlap' with a _class_ that could exist elsewhere in a codebase (like in a gem).

For example, `Sale` is a very generic _class_ name that could very realistically exist in many codebases. Creating a module called `FarMar` allows us to specify _which_ `Sale` we're talking about; `FarMar::Sale` is much more explicit and likely to be unique.

#### Specs & Testing
You must have __90% test coverage__ from `simplecov`. The HTML files that are generated from `simplecov` should _not_ be included in your git repository. Tests should be in the form of __minitest specs__. Complete the necessary boilerplate to create a `Rakefile` and `spec_helper.rb` so that all of your tests run when you run `$ rake` from the project root.

#### Project Data
##### FarMar::Market
Each individual market has many vendors associated with it. The `FarMar::Market` data, in order in the CSV, consists of:

1. ID - (Fixnum) a unique identifier for that market
2. Name - (String) the name of the market (not guaranteed unique)
3. Address - (String) street address of the market
4. City - (String) city in which the market is located
5. County - (String) county in which the market is located
6. State - (String) state in which the market is located
7. Zip - (String) zipcode in which the market is located

##### FarMar::Vendor
Each vendor belongs to a market, the `market_id` field refers to the `FarMar::Market` ID field.
Each vendor has many products for sell. The `FarMar::Vendor` data, in order in the CSV, consists of:

1. ID - (Fixnum) uniquely identifies the vendor
2. Name - (String) the name of the vendor (not guaranteed unique)
3. No. of Employees - (Fixnum) How many employees the vendor has at the market
4. Market_id - (Fixnum) a reference to which market the vendor attends

##### FarMar::Product
Each product belongs to a vendor. The `vendor_id` field refers to the `FarMar::Vendor` ID field. The `FarMar::Product` data, in order in the CSV, consists of:

1. ID - (Fixnum) uniquely identifies the product
2. Name - (String) the name of the product (not guaranteed unique)
3. Vendor_id - (Fixnum) a reference to which vendor sells this product

##### FarMar::Sale
Each sale belongs to a vendor __AND__ a product. The `vendor_id` and `product_id` fields refer to the `FarMar::Vendor` and `FarMar::Product` ID fields, respectively. The `FarMar::Sale` data, in order in the CSV, consists of:

1. ID - (Fixnum) uniquely identifies the sale
2. Amount - (Fixnum) the amount of the transaction, in cents (i.e., 150 would be $1.50)
3. Purchase_time - (Datetime) when the sale was completed
4. Vendor_id - (Fixnum) a reference to which vendor completed the sale
5. Product_id - (Fixnum) a reference to which product was sold

### Requirements
#### Baseline
##### Project Setup
1. You'll be working as an individual on this project.
1. Fork the Ada-C6 repo to your Github account.
1. Clone your fork to your projects directory, and `cd` into the cloned repo.
1. Create a _gemset_ for your project
  1. `$ echo 2.3.0 > .ruby-version`
  1. `$ echo farmar > .ruby-gemset`
  1. `$ cd .`
1. Install necessary gems via Terminal:
  - `$ gem install minitest-reporters`
  - `$ gem install simplecov`

##### Baseline Requirements
- Create a class for each of the data types listed above. Each class should be a part of the `FarMar` module.
- You should be able to create instances of these classes that know about their associated data file.
- Create your `far_mar.rb` file which will bring together all classes created in the previous step.
- Complete the boilerplate necessary for testing. You should be able to `$ rake` from the project root to run your specs. Have at least one spec to verify this setup before submitting your baseline.
- **Once you have completed your baseline, you must submit a pull-request and get it approved by an instructor.**

### Primary Requirements
#### For each of the data classes build the following methods:
1. `self.all`: returns a collection of instances, representing all of the objects described in the CSV
1. `self.find(id)`: returns an instance of the object where the value of the `id` field in the CSV matches the passed parameter.

#### Additional FarMar::Market Methods
1. `#vendors`: returns a collection of `FarMar::Vendor` instances that are associated with the market by the `market_id` field.

#### Additional FarMar::Vendor Methods
1. `#market`: returns the `FarMar::Market` instance that is associated with this vendor using the `FarMar::Vendor` `market_id` field
1. `#products`: returns a collection of `FarMar::Product` instances that are associated by the `FarMar::Product` `vendor_id` field.
1. `#sales`: returns a collection of `FarMar::Sale` instances that are associated by the `vendor_id` field.
1. `#revenue`: returns the the sum of all of the vendor's sales (in cents)
1. `self.by_market(market_id)`: returns all of the vendors with the given `market_id`

#### Additional FarMar::Product Methods
1. `#vendor`: returns the `FarMar::Vendor` instance that is associated with this vendor using the `FarMar::Product` `vendor_id` field
1. `#sales`: returns a collection of `FarMar::Sale` instances that are associated using the `FarMar::Sale` `product_id` field.
1. `#number_of_sales`: returns the number of times this product has been sold.
1. `self.by_vendor(vendor_id)`: returns all of the products with the given `vendor_id`

#### Additional FarMar::Sale Methods
1. `#vendor`: returns the `FarMar::Vendor` instance that is associated with this sale using the `FarMar::Sale` `vendor_id` field
1. `#product`: returns the `FarMar::Product` instance that is associated with this sale using the `FarMar::Sale` `product_id` field
1. `self.between(beginning_time, end_time)`: returns a collection of FarMar::Sale objects where the purchase time is between the two times given as arguments


#### Optional Requirements: Part I
#### FarMar::Market Methods
1. `#products` returns a collection of `FarMar::Product` instances that are associated to the market through the `FarMar::Vendor` class.
1. `self.search(search_term)` returns a collection of `FarMar::Market` instances where the market name or vendor name contain the `search_term`. For example `FarMar::Market.search('school')` would return 3 results, one being the market with id 75 (Fox School Farmers FarMar::Market).
1. `#prefered_vendor`: returns the vendor with the highest revenue
1. `#prefered_vendor(date)`: returns the vendor with the highest revenue for the given date
1. `#worst_vendor`: returns the vendor with the lowest revenue
1. `#worst_vendor(date)`: returns the vendor with the lowest revenue on the given date

#### FarMar::Vendor Methods
1. `self.most_revenue(n)` returns the top n vendor instances ranked by total revenue
1. `self.most_items(n)` returns the top n vendor instances ranked by total number of items sold
1. `self.revenue(date)` returns the total revenue for that date across all vendors
1. `#revenue(date)` returns the total revenue for that specific purchase date and vendor instance

#### FarMar::Product Methods
1. `self.most_revenue(n)` returns the top `n` product instances ranked by total revenue

#### Optional Requirements: Part II
##### For Each Data Class:
- Write additional rspec tests for any methods in the data classes that don't already have test coverage.
- `self.find_by_x(match)`: where `x` is an _attribute_, returns a single instance whose `x` attribute (case-insensitive) equals the `match` parameter. For instance, `FarMar::Vendor.find_by_name("windler inc")` could find a `FarMar::Vendor` with name attribute "windler inc" or "Windler Inc".
- `self.find_all_by_x(match)`: works just like `find_by_x` but returns a collection containing all possible matches. For example `FarMar::Market.find_by_state("WA")` could return all of the `FarMar::Market` objects with `"WA"` in their state field.

##### Try some inheritance or some composition
- __Inheritance:__ Create a new _class_ that defines the shared/duplicated methods (i.e., `find`, `all`). Update your data classes to _inherit_ this _class_ .
- __Composition with a Mixin:__ Create a new _module_ that defines the duplicated methods (i.e., `find`, `all`). Update your data classes to _mixin_ this _module_. 
