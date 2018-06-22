module Promotions
  class WhiteChocolatePromotion
    extend ChocolatePromotion

    WHITE_BONUS = 1
    SUGAR_FREE_BONUS = 1

    def self.bonuses(additional_chocolates)
      {
        "white" => WHITE_BONUS * additional_chocolates,
        "sugar free" => SUGAR_FREE_BONUS * additional_chocolates
      }
    end
  end
end

