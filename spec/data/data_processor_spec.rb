require 'spec_helper'

describe DataProcessor do
  let(:data_processor_instance) do
    described_class.new(
      input_path: input_path,
      output_path: output_path,
      input_format: Proc.new do |data|
        data.join('---')
      end,
      output_format: Proc.new do |data|
        data.split(',,,')
      end
    )
  end
  let(:file_processor) { instance_double(FileTypeProcessor) }
  let(:input_path) { "some/input/path/file.csv" }
  let(:output_path) { "some/output/path/file.csv" }

  before(:each) do
    allow(FileProcessorFactory).to receive(:create) { file_processor }
  end

  describe "#import" do
    subject { data_processor_instance.import }

    before do
      allow(file_processor).to receive(:read).with(input_path: input_path) { ['this', 'is', 'formatted', 'correctly'] }
    end

    it { is_expected.to eq("this---is---formatted---correctly") }
  end

  describe "#export" do
    subject { data_processor_instance.export("this,,,is,,,the,,,data") }

    it "formats the exported data" do
      expect(file_processor).to receive(:write).with(
        output_path: output_path,
        data: ['this', 'is', 'the', 'data']
      )

      subject
    end
  end
end