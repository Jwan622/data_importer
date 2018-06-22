# Getting Started

To run the application:

```
bundle install
```

and then:

```
rake
```

which is shorthand for:

```
rake redeem_orders
```

which is made possible by the usage of a default task in the `Rakefile`:
 
```
task :default => ["redeem_orders"]
```

This task by default will take the csv file located in `public/input/orders.csv` and create (or overwrite) a csv file in `public/output/redemptions.csv` which will contain rows of chocolate totals which were either purchased or redeemed using wrappers. 
 
You can change the default file paths by passing in different paths to the rake command:

```
rake redeem_orders[some/other/input_path/file.csv,some/other/output_path/file.csv]
```

To see all rake tasks, just run:

```
rake -T
```

# Running the Specs
To run all specs:
```
rake spec:all
```

To run only the integration specs:
```
rake spec:integration
```

# Design Choices

The code makes some design choices to abide by OOP principles like Open/Closed, Single Responsibility, and Dependency Inversion. The code also makes use of duck-typing and avoids unnecessary data classes with no functionality. Lastly, reusability was prioritized so that files with different extensions, input paths, and output paths could be read and written and different data transformation logic could be applied. Here is a short analysis of some choices:

In order to abide by Open/Closed Principle, I created a `FileTypeProcessor` module to help future concrete classes abide by the same contract as the existing `CSVProcessor`. In the future, we can add different kinds of processors without having to change any code in the client. Any new processing behavior for different text or yaml files will only require the addition of new processors.

The same application of Open/Closed Principle and duck-typing exists in the `chocolate_totals_calculator.rb`:

```ruby
Promotions::PromotionsFactory.create(choc).bonuses(bonus_chocolates)
```

In the above code, the `PromotionsFactory` is responsible for creating a `Promotion` object which implements a common interface: `bonuses`. When trading in wrappers for a specific chocolate, that chocolate is also used to determine which promotion bonus to apply. Once the appropriate bonus is determined, we apply the bonus by calling its `bonuses` method which will multiply the appropriate bonus amount(s) by the number of chocolates redeemed for wrappers. All of this is handled elegantly through polymorphism/duck-typing.

#### Reusability
If you walk through the code starting with the `Rakefile`, you can see that most of it makes very little mention of chocolates or wrappers. The `Rakefile` calls this code:

```ruby
DataController.transfer(
  input_path:  args[:orders_csv_path],
  output_path: args[:redemptions_csv_path],
  input_format: input_format,
  output_format: output_format
)
```

which in turns calls this:

```ruby
DataProcessor.new
```

which in turn calls this:

```ruby
CSV.read(input_path, ...)
```

and

```ruby
def self.write(output_path:, data:)
```

All of that code can be generically used to read files, process the data, and write to a file. The processing step is where the chocolate-related code hooks into the application. Until then, most of the classes are  agnostic to the fact that we're dealing with chocolate, orders, wrappers, and redemptions. The only piece of code in the main flow that is specific and tied to those concepts exists as a proc: 

```ruby
input_format = Proc.new do |data|
  data.map do |csv_row|
    ChocolateTotalsCalculator.new(csv_row).calculate
  end
end
```

The above code is the only code responsible for converting the input data into its final form that will eventually be written to a new csv at the new path. This is intended to maximize reusability of the data-related classes, separate concerns (data processing should know nothing about chocolate), and to reduce the dependency between the high level data processing classes and the lower level chocolate-data classes.

#### Last notes on design:
- I originally had the data formatting functionality (currently written as procs in the `Rakefile`) as separate classes like `ChocolateInputFormatter` and  `ChocolateOutputFormatter`. But since I only need the functionality and did not need these classes to become objects for duck-tying in the same way as the various chocolate `Promotion` classes, I converted the formatting functionality to procs instead.
- I considered collapsing the `DataController` and the `DataProcessor` to be one class but it seemed like the transfer of data and the read/write of data should be separated concerns. So, I separated them. 