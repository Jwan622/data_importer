module FileTypeProcessor
  def read(input_path:, with_headers: nil, return_headers: nil)
    raise MethodNotImplementedError
  end

  def write(output_path:, data:)
    raise MethodNotImplementedError
  end
end