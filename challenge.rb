require_relative './app/product_totals'
require_relative './app/receipt_details'
require_relative './app/receipt_printer'

class Challenge
  def call
    ReceiptPrinter.new(totals).print
  end

  def totals
    details.reduce(ProductTotals.new) do |product_total, product_detail|
      product_total << product_detail
      product_total
    end
  end

  def details
    ReceiptDetails.new.call
  end
end

if ARGV.first == '--run'
  Challenge.new.call
end
