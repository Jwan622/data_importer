require 'spec_helper'

describe DataController do
  describe ".transfer" do
    subject do
      described_class.transfer(
        input_path: input_path,
        output_path: output_path,
        input_format: input_format,
        output_format: output_format
      )
    end

    let(:input_path) { "some/input/path/file.csv" }
    let(:output_path) { "some/output/path/file.csv" }
    let(:input_format) { Proc.new { |data| data.join('---') } }
    let(:output_format) { Proc.new { |data| data.join(',,,') } }

    let(:data_processor) { class_double("DataProcessor").as_stubbed_const }
    let(:data_processor_instance) { instance_double("DataProcessor") }
    let(:imported_data) { "some data in some format" }

    before(:each) do
      allow(data_processor_instance).to receive(:import) { imported_data }
    end

    it "exports the imported data" do
      expect(data_processor).to receive(:new).with(
        input_path: input_path,
        output_path: output_path,
        input_format: input_format,
        output_format: output_format
      ) { data_processor_instance }
      expect(data_processor_instance).to receive(:export).with(imported_data)

      subject
    end

  end
end