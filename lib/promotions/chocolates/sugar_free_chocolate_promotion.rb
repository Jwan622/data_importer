module Promotions
  class SugarFreeChocolatePromotion
    extend ChocolatePromotion

    SUGAR_FREE_BONUS = 1
    DARK_BONUS = 1

    def self.bonuses(additional_chocolates)
      {
        "sugar free" => SUGAR_FREE_BONUS * additional_chocolates,
        "dark" => DARK_BONUS * additional_chocolates
      }
    end
  end
end
