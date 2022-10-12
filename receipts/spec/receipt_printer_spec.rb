require 'spec_helper'
require_relative '../app/receipt_printer'
require_relative '../app/product_totals'
require_relative '../app/product_detail'


describe ReceiptPrinter do
  subject(:receipt_printer) do
    described_class.new(product_totals).print
  end

  let(:product_totals) do
    instance_double(ProductTotals, products: product_details, total_sales_tax: 1.499, total: 42.319 )
  end

  let(:product_details) do
    [
      instance_double(ProductDetail, name: 'book', amount: 2, price_with_taxes: 24.98, sales_tax: 0),
      instance_double(ProductDetail, name: 'music CD', amount: 1, price_with_taxes: 16.489, sales_tax: 1.499),
      instance_double(ProductDetail, name: 'chocolate bar', amount: 1, price_with_taxes: 0.85, sales_tax: 0)
    ]
  end

  it 'correctly outputs to stdout'do
    message = "2 book: 24.98\n1 music CD: 16.49\n1 chocolate bar: 0.85\nSales Taxes: 1.50\nTotal: 42.32\n"
    expect { receipt_printer }.to output(message).to_stdout
  end
end
