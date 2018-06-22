require 'rake'
require 'rspec/core/rake_task'
# need to require modules first
require './lib/promotions/chocolates/chocolate_promotion'
require './lib/data/file_type_processor'
Dir["./lib/**/*.rb"].each {|file| require file }

task :default => ["redeem_orders"]

namespace :spec do
  desc "Run all tests"
  RSpec::Core::RakeTask.new('all') do |t|
    t.pattern = Dir.glob('spec/**/*_spec.rb')
  end

  desc "Run all integration tests only"
  RSpec::Core::RakeTask.new('integration') do |t|
    t.pattern = Dir.glob('spec/integration/*_spec.rb')
  end
end

desc "Calculate chocolate totals from a CSV of orders"
task :redeem_orders, [:orders_csv_path, :redemptions_csv_path] do |t, args|
  args.with_defaults(:orders_csv_path => "./public/input/orders.csv", :redemptions_csv_path => "./public/output/redemptions.csv")
  puts "input path is #{args[:orders_csv_path]} and output path is #{args[:redemptions_csv_path]}"
  input_format = Proc.new do |data|
    data.map do |csv_row|
      ChocolateTotalsCalculator.new(csv_row).calculate
    end
  end
  output_format = Proc.new do |data|
    data.map do |datum|
      datum.map do |chocolate_type, total|
        "#{chocolate_type} #{total}"
      end
    end
  end
  DataController.transfer(
    input_path:  args[:orders_csv_path],
    output_path: args[:redemptions_csv_path],
    input_format: input_format,
    output_format: output_format
  )
  puts "Finished running the redeem_orders task. Output file to #{args[:redemptions_csv_path]}"
end