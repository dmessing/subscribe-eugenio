class ProductDetail
  attr_reader :name, :amount, :unit_price, :is_imported, :is_exempt
  attr_accessor :sales_tax

  alias imported? is_imported
  alias exempt? is_exempt

  def initialize(name:, amount:, unit_price:, is_imported:, is_exempt:)
    @name = name
    @amount = amount
    @unit_price = unit_price
    @is_imported = is_imported
    @is_exempt = is_exempt
    @sales_tax = 0
  end

  def total_net_price
    unit_price * amount
  end

  def price_with_taxes
    total_net_price + sales_tax
  end
end
