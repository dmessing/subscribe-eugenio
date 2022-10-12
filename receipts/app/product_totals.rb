class ProductTotals
  attr_accessor :total, :total_sales_tax, :products

  BASIC_SALES_TAX = 0.1
  IMPORT_DUTY = 0.05

  def initialize
    @products = []
    @total = 0
    @total_sales_tax = 0
  end

  def <<(product_detail)
    product_detail.sales_tax = calculate_taxes(product_detail)

    @total_sales_tax += product_detail.sales_tax
    @total += product_detail.price_with_taxes

    @products.push(product_detail)
  end

  def calculate_taxes(product_detail)
    import_tax(product_detail) + sales_tax(product_detail)
  end

  def import_tax(product_detail)
    return 0 unless product_detail.imported?

    product_detail.amount.times.reduce(0) do |total, _|
      total + round(product_detail.unit_price * IMPORT_DUTY)
    end
  end

  def sales_tax(product_detail)
    return 0 if product_detail.exempt?

    product_detail.amount.times.reduce(0) do |total, _|
      total + round(product_detail.unit_price * BASIC_SALES_TAX)
    end
  end

  def round(amount)
    (amount * 20).ceil / 20.0
  end
end
