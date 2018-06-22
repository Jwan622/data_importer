class MethodNotImplementedError < StandardError
  def initialize(msg="Method not implemented!")
    super
  end
end

class NoPromotionImplementedError < StandardError
  def initialize(msg="No Promotion Exists!")
    super
  end
end

class InvalidOrderError < StandardError
  def initialize(msg="Order has a price of 0!")
    super
  end
end

class ExtensionUnsupported < StandardError
  def initialize(msg="Extension not supported as of yet!")
    super
  end
end