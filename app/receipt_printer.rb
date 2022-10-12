
class ReceiptPrinter
  attr_reader :product_totals

  def initialize(product_totals)
    @product_totals = product_totals
  end

  def print
    product_totals.products.each do |product_detail|
      puts product_message(product_detail)
    end
    puts taxes_message(product_totals.total_sales_tax)
    puts total_message(product_totals.total)
  end

  def product_message(product_detail)
    "#{product_detail.amount} #{product_detail.name}: #{round_amount(product_detail.price_with_taxes)}"
  end

  def taxes_message(taxes)
    "Sales Taxes: #{round_amount(taxes)}"
  end

  def total_message(total)
    "Total: #{round_amount(total)}"
  end

  def round_amount(amount)
    sprintf("%.2f", amount)
  end
end
