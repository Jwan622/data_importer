require 'spec_helper'

describe FileTypeProcessor do
  let(:dummy_class) { Class.new { extend FileTypeProcessor } }
  let(:input_path) { "some/input/path/file.csv" }
  let(:output_path) { "some/output/path/file.csv" }
  let(:data) { ['some', 'arbitrary', 'data'] }

  it "is a file type processor" do
    expect(dummy_class).to be_a_kind_of(FileTypeProcessor)
  end

  describe ".read" do
    subject { dummy_class.read(input_path: input_path) }

    it "raises an error if unimplemented" do
      expect{ subject }.to raise_error(MethodNotImplementedError)
    end
  end

  describe ".write" do
    subject { dummy_class.write(output_path: output_path, data: data) }

    it "raises an error if unimplemented" do
      expect{ subject }.to raise_error(MethodNotImplementedError)
    end
  end
end

