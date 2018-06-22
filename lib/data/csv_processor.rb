require 'csv'

class CsvProcessor
  extend FileTypeProcessor

  def self.read(input_path:, with_headers: true, return_headers: false)
    CSV.read(input_path, headers: with_headers, return_headers: return_headers, converters: :numeric)
  end

  def self.write(output_path:, data:)
    CSV.open(output_path, "w") do |csv|
      data.each do |row|
        csv << row
      end
    end
  end
end