require 'spec_helper'

describe Promotions::ChocolatePromotion do
  let(:dummy_class) { Class.new { extend Promotions::ChocolatePromotion } }
  let(:additional_chocolates) { 2 }

  describe "#bonuses" do
    subject { dummy_class.bonuses(additional_chocolates) }

    it "raises an error if unimplemented" do
      expect{ subject }.to raise_error(MethodNotImplementedError)
    end
  end
end

