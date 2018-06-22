require 'spec_helper'

describe Promotions::PromotionsFactory do
  describe ".create" do
    subject { described_class.create(chocolate) }

    context "when chocolate is milk" do
      let(:chocolate) { "milk" }

      it { is_expected.to eq(Promotions::MilkChocolatePromotion) }
    end

    context "when chocolate is dark" do
      let(:chocolate) { "dark" }

      it { is_expected.to eq(Promotions::DarkChocolatePromotion) }
    end

    context "when chocolate is white" do
      let(:chocolate) { "white" }

      it { is_expected.to eq(Promotions::WhiteChocolatePromotion) }
    end

    context "when chocolate is sugar free" do
      let(:chocolate) { "sugar free" }

      it { is_expected.to eq(Promotions::SugarFreeChocolatePromotion) }
    end

    context "when chocolate is not supported" do
      let(:chocolate) { "extraEXTRADARK99.999999CACAOOMGGGZZZZZ" }

      it "raises an NoPromotionImplementedError" do
        expect{ subject }.to raise_error(NoPromotionImplementedError)
      end
    end
  end
end