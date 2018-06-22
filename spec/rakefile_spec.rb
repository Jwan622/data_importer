require 'spec_helper'

describe 'Rakefile' do
  describe "redeem_orders" do
    context "with default paths" do
      subject { Rake::Task['redeem_orders'].invoke }

      let(:input_path) { "./public/input/orders.csv" }
      let(:output_path) { "./public/output/redemptions.csv" }

      it "transfer the data from input to output path" do
        expect(DataController).to receive(:transfer).with(
          input_path: input_path,
          output_path: output_path,
          input_format: kind_of(Proc),
          output_format: kind_of(Proc)
        )

        subject
      end
    end

    context "with different paths" do
      subject { Rake::Task['redeem_orders'].invoke(some_new_input_path, some_new_output_path) }

      let(:some_new_input_path) { "./some/new/path/orders.csv" }
      let(:some_new_output_path) { "./some/new/path/redemptions.csv" }

      it "transfer the data from input to output path" do
        expect(DataController).to receive(:transfer).with(
          input_path: some_new_input_path,
          output_path: some_new_output_path,
          input_format: kind_of(Proc),
          output_format: kind_of(Proc)
        )

        subject
      end
    end
  end
end

