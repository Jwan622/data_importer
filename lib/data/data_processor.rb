class DataProcessor
  attr_reader :input_path,
    :output_path,
    :input_format,
    :output_format,
    :input_file_processor,
    :output_file_processor

  def initialize(input_path:, output_path:, input_format:, output_format:)
    @input_path = input_path
    @output_path = output_path
    @input_format = input_format
    @output_format = output_format
    @input_file_processor = FileProcessorFactory.create(File.extname(input_path))
    @output_file_processor = FileProcessorFactory.create(File.extname(output_path))
  end

  def import
    input_format.call(input_file_processor.read(input_path: input_path))
  end

  def export(export_data)
    output_file_processor.write(
      output_path: output_path,
      data: output_format.call(export_data)
    )
  end
end