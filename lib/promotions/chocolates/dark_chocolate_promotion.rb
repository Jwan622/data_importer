module Promotions
  class DarkChocolatePromotion
    extend ChocolatePromotion

    DARK_BONUS = 1

    def self.bonuses(additional_chocolates)
      {
        "dark" => DARK_BONUS * additional_chocolates
      }
    end
  end
end

