require 'spec_helper'

describe Promotions::DarkChocolatePromotion do
  let(:multiplier) { 2 }

  it "extends Chocolate Promotion" do
    expect(described_class.singleton_class.included_modules).to include(Promotions::ChocolatePromotion)
  end

  describe ".bonuses" do
    subject { described_class.bonuses(multiplier) }
    let(:expected_bonus) { { "dark" => 2 } }

    it { is_expected.to eq(expected_bonus) }
  end
end