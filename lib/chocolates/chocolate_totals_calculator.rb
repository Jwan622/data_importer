require 'ostruct'

class ChocolateTotalsCalculator
  attr_reader :order,
    :chocolates,
    :wrappers

  CHOCOLATE_VARIETIES = [
    "milk",
    "dark",
    "white",
    "sugar free"
  ]

  def initialize(row)
    @order = build_order(row)
    initialize_totals
  end

  def calculate
    spend_cash
    trade_in_wrappers
    chocolates
  end

  private

  def spend_cash
    return false if order.cash == 0

    increment_totals(order.type, purchasable_chocolates)
    order.cash = order.cash - order.price * purchasable_chocolates
  end

  def trade_in_wrappers
    return false if wrappers.values.all? { |value| value < order.wrappers || value == 0 }

    while wrappers.values.any? {|value| value >= order.wrappers }
      wrappers.select{ |_, value| value >= order.wrappers }.each do |choc, _|
        bonus_chocolates = additional_chocolates(choc)
        Promotions::PromotionsFactory.create(choc).bonuses(bonus_chocolates).each do |chocolate_type, bonus|
          increment_totals(chocolate_type, bonus)
        end
        wrappers[choc] -= order.wrappers * bonus_chocolates
      end
    end
  end

  def build_order(row)
    OpenStruct.new(cash: row["cash"], price: row["price"], wrappers: row["wrappers needed"], type: row["type"])
  end

  def initialize_totals
    @chocolates = Hash.new
    @wrappers = Hash.new

    CHOCOLATE_VARIETIES.each do |variety|
      chocolates[variety] = 0
      wrappers[variety] = 0
    end
  end

  def purchasable_chocolates
    return 0 if order.cash == 0
    raise InvalidOrderError if order.price == 0

    order.cash / order.price
  end

  def increment_totals(chocolate_type, amount)
    chocolates[chocolate_type] += amount
    wrappers[chocolate_type] += amount
  end

  def additional_chocolates(chocolate_type)
    return 0 if order.wrappers == 0

    wrappers[chocolate_type] / order.wrappers
  end
end