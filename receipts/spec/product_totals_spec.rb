require 'spec_helper'
require_relative '../app/product_totals'
require_relative '../app/product_detail'

describe ProductTotals do
  subject(:product_totals) do
    described_class.new
  end

  let(:products) do
    [
      instance_double(ProductDetail, name: 'Test product 1', amount: 1, unit_price: 20,
                      imported?: false, exempt?: true, total_net_price: 20, 'sales_tax=' => 0,
                      sales_tax: 0, price_with_taxes: 20),
      instance_double(ProductDetail, name: 'Test product 2', amount: 1, unit_price: 100,
                      imported?: false, exempt?: false, total_net_price: 100, 'sales_tax=' => 10,
                      sales_tax: 10, price_with_taxes: 110),
      instance_double(ProductDetail, name: 'Test product 3', amount: 2, unit_price: 50,
                      imported?: true, exempt?: false, total_net_price: 100, 'sales_tax=' => 15,
                      sales_tax: 15, price_with_taxes: 115),
      instance_double(ProductDetail, name: 'Test product 4', amount: 1, unit_price: 80,
                      imported?: true, exempt?: true, total_net_price: 80, 'sales_tax=' => 4,
                      sales_tax: 4, price_with_taxes: 84)
    ]
  end

  describe 'constants', aggregate_failures: true do
    it 'has expected values for constants' do
      expect(described_class::BASIC_SALES_TAX).to eq(0.1)
      expect(described_class::IMPORT_DUTY).to eq(0.05)
    end
  end

  context 'when initialized', aggregate_failures: true do
    it 'has expected values for attributes' do
      expect(product_totals.products).to match_array([])
      expect(product_totals.total).to eq(0)
      expect(product_totals.total_sales_tax).to eq(0)
    end
  end

  context 'when adding products' do
    before do
      products.each { |product| product_totals << product }
      allow(products[0]).to receive(:sales_tax=).and_return(0)
      allow(products[1]).to receive(:sales_tax=).and_return(10)
      allow(products[2]).to receive(:sales_tax=).and_return(15)
      allow(products[3]).to receive(:sales_tax=).and_return(4)
    end

    it 'correctly assigns tax', aggregate_failures: true do
      product_totals
      expect(products[0]).to have_received(:sales_tax=).with(0).once
      expect(products[1]).to have_received(:sales_tax=).with(10).once
      expect(products[2]).to have_received(:sales_tax=).with(15).once
      expect(products[3]).to have_received(:sales_tax=).with(4).once
    end

    it 'has correct products' do
      expect(product_totals.products).to match_array(products)
    end

    it 'has correct total' do
      expect(product_totals.total).to eq(20 + 110 + 115 + 84)
    end
  end
end
