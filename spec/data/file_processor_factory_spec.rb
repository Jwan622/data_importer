require 'spec_helper'

describe FileProcessorFactory do
  describe ".create" do
    subject { described_class.create(extension) }

    let!(:some_processor) { class_double("CsvProcessor").as_stubbed_const }

    context "extension supported" do
      let(:extension) { '.csv' }

      it { is_expected.to be(some_processor) }
    end

    context "extension not supported" do
      let(:extension) { '.zip' }

      it "raises an ExtensionUnsupported error" do
        expect{ subject }.to raise_error(ExtensionUnsupported)
      end
    end
  end
end