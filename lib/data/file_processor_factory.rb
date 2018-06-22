class FileProcessorFactory
  def self.create(extension)
    if extension == '.csv'
      CsvProcessor
    else
      raise ExtensionUnsupported
    end
  end
end