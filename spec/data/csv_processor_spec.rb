require 'spec_helper'

describe CsvProcessor do
  let(:csv_class) { class_double("CSV").as_stubbed_const }

  it "extends FileTypeProcessor" do
    expect(CsvProcessor.singleton_class.included_modules).to include(FileTypeProcessor)
  end

  describe ".read" do
    subject { described_class.read(input_path: input_path) }

    let(:input_path) { "some/input/path/file.csv" }

    it "reads the csv" do
      expect(csv_class).to receive(:read).with(input_path, headers: true, return_headers: false, converters: :numeric)

      subject
    end
  end

  describe ".write" do
    subject { described_class.write(output_path: output_path, data: data) }

    let(:output_path) { "some/output/path/file.csv" }
    let(:data) { ['some','arbitrary','data'] }
    let(:csv_object) { instance_double('CSV') }

    it "writes to the csv" do
      expect(csv_class).to receive(:open).with(output_path, "w").and_yield(csv_object)
      expect(csv_object).to receive(:<<).with('some')
      expect(csv_object).to receive(:<<).with('arbitrary')
      expect(csv_object).to receive(:<<).with('data')

      subject
    end
  end
end