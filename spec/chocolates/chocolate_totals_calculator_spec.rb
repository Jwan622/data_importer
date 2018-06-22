require 'spec_helper'

describe ChocolateTotalsCalculator do
  let(:chocolate_calculator) { described_class.new(row) }
  let(:row) { CSV::Row.new(csv_headers, [0,0,0,"milk"]) }
  let(:csv_headers) { ["cash", "price", "wrappers needed", "type"] }

  describe "#calculate" do
    subject { chocolate_calculator.calculate }

    shared_examples "a fully redeemed set of chocolates" do |context_name|
      it "returns a final set of chocolates: #{context_name}" do
        expect(subject).to eq(final_chocolates)
        expect(chocolate_calculator.wrappers).to eq(final_wrappers)
      end
    end

    context "wrappers are redeemed zero times" do
      context "row is [cash: 0, price: 0, wrappers: 0, type: 'dark']" do
        let(:row) { CSV::Row.new(csv_headers,[0,0,0,"dark"]) }
        let(:final_chocolates) { { "milk" => 0, "dark" => 0, "white" => 0, "sugar free" => 0 } }
        let(:final_wrappers) { { "milk" => 0, "dark" => 0, "white" => 0, "sugar free" => 0 } }

        it_behaves_like "a fully redeemed set of chocolates", description
      end

      context "row is [cash: 12, price: 4, wrappers: 4, type: 'dark']" do
        let(:row) { CSV::Row.new(csv_headers,[12,4,4,"dark"]) }
        let(:final_chocolates) { { "milk" => 0, "dark" => 3, "white" => 0, "sugar free" => 0 } }
        let(:final_wrappers) { { "milk" => 0, "dark" => 3, "white" => 0, "sugar free" => 0 } }

        it_behaves_like "a fully redeemed set of chocolates", description
      end

      context "row is [cash: 10, price: 5, wrappers: 5, type: 'white']" do
        let(:row) { CSV::Row.new(csv_headers,[10,5,5,"white"]) }
        let(:final_chocolates) { { "milk" => 0, "dark" => 0, "white" => 2, "sugar free" => 0 } }
        let(:final_wrappers) { { "milk" => 0, "dark" => 0, "white" => 2, "sugar free" => 0 } }

        it_behaves_like "a fully redeemed set of chocolates", description
      end
    end

    context "wrappers are redeemed once" do
      context "row is [cash: 14, price: 2, wrappers: 6, type: 'milk']" do
        let(:row) { CSV::Row.new(csv_headers,[14,2,6,"milk"]) }
        let(:final_chocolates) { { "milk" => 8, "dark" => 0, "white" => 0, "sugar free" => 1 } }
        let(:final_wrappers) { { "milk" => 2, "dark" => 0, "white" => 0, "sugar free" => 1 } }

        it_behaves_like "a fully redeemed set of chocolates", description
      end

      context "row is [cash: 12, price: 2, wrappers: 5, type: 'milk']" do
        let(:row) { CSV::Row.new(csv_headers,[12,2,5,"milk"]) }
        let(:final_chocolates) { { "milk" => 7, "dark" => 0, "white" => 0, "sugar free" => 1 } }
        let(:final_wrappers) { { "milk" => 2, "dark" => 0, "white" => 0, "sugar free" => 1 } }

        it_behaves_like "a fully redeemed set of chocolates", description
      end

      context "row is [cash: 14, price: 7, wrappers: 2, type: 'milk']" do
        let(:row) { CSV::Row.new(csv_headers,[14,7,2,"milk"]) }
        let(:final_chocolates) { { "milk" => 3, "dark" => 0, "white" => 0, "sugar free" => 1 } }
        let(:final_wrappers) { { "milk" => 1, "dark" => 0, "white" => 0, "sugar free" => 1 } }

        it_behaves_like "a fully redeemed set of chocolates", description
      end

      context "row is [cash: 30, price: 10, wrappers: 3, type: 'white']" do
        let(:row) { CSV::Row.new(csv_headers, [30,10,3,"white"]) }
        let(:final_chocolates) { { "milk" => 0, "dark" => 0, "white" => 4, "sugar free" => 1 } }
        let(:final_wrappers) { { "milk" => 0, "dark" => 0, "white" => 1, "sugar free" => 1 } }

        it_behaves_like "a fully redeemed set of chocolates", description
      end

      context "row is [cash: 20, price: 8, wrappers: 2, type: 'dark']" do
        let(:row) { CSV::Row.new(csv_headers, [20,8,2,"dark"]) }
        let(:final_chocolates) { { "milk" => 0, "dark" => 3, "white" => 0, "sugar free" => 0 } }
        let(:final_wrappers) { { "milk" => 0, "dark" => 1, "white" => 0, "sugar free" => 0 } }

        it_behaves_like "a fully redeemed set of chocolates", description
      end

      context "row is [cash: 28, price: 9, wrappers: 3, type: 'sugar free']" do
        let(:row) { CSV::Row.new(csv_headers, [28,9,3,"sugar free"]) }
        let(:final_chocolates) {  { "milk" => 0, "dark" => 1, "white" => 0, "sugar free" => 4 } }
        let(:final_wrappers) { { "milk" => 0, "dark" => 1, "white" => 0, "sugar free" => 1 } }

        it_behaves_like "a fully redeemed set of chocolates", description
      end
    end

    context "wrappers are redeemed twice" do
      context "row is [cash: 8, price: 2, wrappers: 2, type: 'dark']" do
        let(:row) { CSV::Row.new(csv_headers, [8,2,2,"dark"]) }
        let(:final_chocolates) { { "milk" => 0, "dark" => 7, "white" => 0, "sugar free" => 0 } }
        let(:final_wrappers) { { "milk" => 0, "dark" => 1, "white" => 0, "sugar free" => 0 } }

        it_behaves_like "a fully redeemed set of chocolates", description
      end

      context "row is [cash: 16, price: 3, wrappers: 3, type: 'sugar free']" do
        let(:row) { CSV::Row.new(csv_headers, [16,3,3,"sugar free"]) }
        let(:final_chocolates) {  { "milk" => 0, "dark" => 2, "white" => 0, "sugar free" => 7 } }
        let(:final_wrappers) { { "milk" => 0, "dark" => 2, "white" => 0, "sugar free" => 1 } }

        it_behaves_like "a fully redeemed set of chocolates", description
      end

      context "row is [cash: 30, price: 5, wrappers: 3, type: 'white']" do
        let(:row) { CSV::Row.new(csv_headers, [35,5,4,"white"]) }
        let(:final_chocolates) { { "milk" => 0, "dark" => 0, "white" => 9, "sugar free" => 2 } }
        let(:final_wrappers) { { "milk" => 0, "dark" => 0, "white" => 1, "sugar free" => 2 } }

        it_behaves_like "a fully redeemed set of chocolates", description
      end
    end

    context "wrappers redeemed thrice" do
      context "row is [cash: 6, price: 2, wrappers: 2, type: 'white']" do
        let(:row) { CSV::Row.new(csv_headers, [6,2,2,"white"]) }
        let(:final_chocolates) { { "milk" => 0, "dark" => 1, "white" => 5, "sugar free" => 3 } }
        let(:final_wrappers) { { "milk" => 0, "dark" => 1, "white" => 1, "sugar free" => 1 } }

        it_behaves_like "a fully redeemed set of chocolates", description
      end

      context "row is [cash: 6, price: 2, wrappers: 2, type: 'sugar free']" do
        let(:row) { CSV::Row.new(csv_headers, [6,2,2,"sugar free"]) }
        let(:final_chocolates) {  { "milk" => 0, "dark" => 3, "white" => 0, "sugar free" => 5 } }
        let(:final_wrappers) { { "milk" => 0, "dark" => 1, "white" => 0, "sugar free" => 1 } }

        it_behaves_like "a fully redeemed set of chocolates", description
      end

      context "row is [cash: 12, price: 4, wrappers: 2, type: 'sugar free']" do
        let(:row) { CSV::Row.new(csv_headers, [12,4,2,"sugar free"]) }
        let(:final_chocolates) {  { "milk" => 0, "dark" => 3, "white" => 0, "sugar free" => 5 } }
        let(:final_wrappers) { { "milk" => 0, "dark" => 1, "white" => 0, "sugar free" => 1 } }

        it_behaves_like "a fully redeemed set of chocolates", description
      end
    end
  end

  describe "#spend_cash" do
    subject { chocolate_calculator.send(:spend_cash) }

    context "order cash is 0" do
      let(:row) { CSV::Row.new(csv_headers, [0,1,0,"milk"]) }

      it "does not buy any chocolate" do
        expect(subject).to eq(false)

        expect(chocolate_calculator.chocolates).to eq({ "milk"=>0, "dark"=>0, "white"=>0, "sugar free"=>0 })
        expect(chocolate_calculator.wrappers).to eq({ "milk"=>0, "dark"=>0, "white"=>0, "sugar free"=>0 })
        expect(chocolate_calculator.order.cash).to eq(0)
      end
    end

    context "order cash equal to price" do
      let(:row) { CSV::Row.new(csv_headers, [1,1,0,"milk"]) }

      it "does not buy any chocolate" do
        subject

        expect(chocolate_calculator.chocolates).to eq({ "milk"=>1, "dark"=>0, "white"=>0, "sugar free"=>0 })
        expect(chocolate_calculator.wrappers).to eq({ "milk"=>1, "dark"=>0, "white"=>0, "sugar free"=>0 })
        expect(chocolate_calculator.order.cash).to eq(0)
      end
    end

    context "order cash is less than price" do
      let(:row) { CSV::Row.new(csv_headers, [1,2,0,"milk"]) }

      it "does not buy any chocolate" do
        subject

        expect(chocolate_calculator.chocolates).to eq({ "milk"=>0, "dark"=>0, "white"=>0, "sugar free"=>0 })
        expect(chocolate_calculator.wrappers).to eq({ "milk"=>0, "dark"=>0, "white"=>0, "sugar free"=>0 })
        expect(chocolate_calculator.order.cash).to eq(1)
      end
    end
  end

  describe "#purchasable_chocolates" do
    subject { chocolate_calculator.send(:purchasable_chocolates) }

    context "purchasable scenarios" do
      context "order price is equal to order cash" do
        let(:row) { CSV::Row.new(csv_headers, [2,2,0,"milk"]) }

        it { is_expected.to eq(1) }
      end

      context "order price is slightly less than order cash" do
        let(:row) { CSV::Row.new(csv_headers, [1,2,0,"milk"]) }

        it { is_expected.to eq(0) }
      end

      context "order price is slightly greater than order cash" do
        let(:row) { CSV::Row.new(csv_headers, [3,2,0,"milk"]) }

        it { is_expected.to eq(1) }
      end
    end

    context "non-purchasable scenarios" do
      context "order price is 0" do
        let(:row) { CSV::Row.new(csv_headers, [2,0,0,"milk"]) }

        it "raises an error" do
          expect { subject }.to raise_error(InvalidOrderError, "Order has a price of 0!")
        end
      end

      context "order cash is 0" do
        let(:row) { CSV::Row.new(csv_headers, [0,2,0,"milk"]) }

        it { is_expected.to eq(0) }
      end

      context "order cash and order price are both 0" do
        let(:row) { CSV::Row.new(csv_headers, [0,0,0,"milk"]) }

        it { is_expected.to eq(0) }
      end
    end
  end

  describe "#trade_in_wrappers" do
    subject { chocolate_calculator.send(:trade_in_wrappers) }

    before(:each) do
      allow(chocolate_calculator.order).to receive(:wrappers) { required_wrappers }
      allow(chocolate_calculator).to receive(:wrappers) { available_wrappers }
    end

    context "if all wrappers are non-tradeable" do
      context "if all wrappers are less than the required amount" do
        let(:available_wrappers) { { "milk" => 0, "dark" => 0, "white" => 0, "sugar free" => 4} }
        let(:required_wrappers) { 5 }

        it { is_expected.to eq(false) }
      end

      context "if all wrappers are 0" do
        let(:available_wrappers) { { "milk" => 0, "dark" => 0, "white" => 0, "sugar free" => 0} }
        let(:required_wrappers) { 1 }

        it { is_expected.to eq(false) }
      end
    end

    context "wrapper are tradeable" do
      let(:available_wrappers) { { "milk" => 4, "dark" => 0, "white" => 0, "sugar free" => 0} }
      let(:required_wrappers) { 4 }
      let(:milk_promotion) { class_double(Promotions::MilkChocolatePromotion) }
      let(:bonus) { { "milk" => 1} }

      before do
        allow(Promotions::PromotionsFactory).to receive(:create) { milk_promotion }
      end

      it "correctly changes the chocolates and wrappers" do
        expect(milk_promotion).to receive(:bonuses).with(1) { bonus }

        subject
      end
    end
  end

  describe "#additional_chocolates" do
    subject { chocolate_calculator.send(:additional_chocolates, "milk") }

    let(:available_wrappers) { { "milk" => 2, "dark" => 0, "white" => 0, "sugar free" => 0} }

    before do
      allow(chocolate_calculator).to receive(:wrappers) { available_wrappers }
    end

    context "order wrappers is 0" do
      it { is_expected.to eq(0) }
    end

    context "the available wrapper is evenly divisible by the order wrappers" do
      let(:available_wrappers) { { "milk" => 2, "dark" => 0, "white" => 0, "sugar free" => 0} }
      let(:row) { CSV::Row.new(csv_headers, [0,0,2,"milk"]) }

      it { is_expected.to eq(1) }
    end
  end
end