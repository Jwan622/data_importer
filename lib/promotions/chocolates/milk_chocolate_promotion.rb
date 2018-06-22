module Promotions
  class MilkChocolatePromotion
    extend ChocolatePromotion

    MILK_BONUS = 1
    SUGAR_FREE_BONUS = 1

    def self.bonuses(additional_chocolates)
      {
        "milk" => MILK_BONUS * additional_chocolates,
        "sugar free" => SUGAR_FREE_BONUS * additional_chocolates
      }
    end
  end
end

