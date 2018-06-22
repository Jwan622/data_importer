class DataController
  def self.transfer(input_path:, output_path:, input_format:, output_format:)
    data_processor = DataProcessor.new(
      input_path: input_path,
      output_path: output_path,
      input_format: input_format,
      output_format: output_format
    )

    data_processor.export(data_processor.import)
  end
end