module Promotions
  class PromotionsFactory
    CHOCOLATE_TYPES = {
      milk: "milk",
      white: "white",
      dark: "dark",
      sugar_free: "sugar free"
    }

    def self.create(choc)
      case choc
      when CHOCOLATE_TYPES[:milk]
        MilkChocolatePromotion
      when CHOCOLATE_TYPES[:white]
        WhiteChocolatePromotion
      when CHOCOLATE_TYPES[:dark]
        DarkChocolatePromotion
      when CHOCOLATE_TYPES[:sugar_free]
        SugarFreeChocolatePromotion
      else
        raise NoPromotionImplementedError
      end
    end
  end
end
