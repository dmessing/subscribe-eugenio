require 'spec_helper'
require_relative '../app/product_detail'

describe ProductDetail do
  subject(:product_detail) do
    described_class.new(params)
  end

  let(:params) do
    { name: 'Test product', amount: 2, unit_price: 100, is_imported: false,
      is_exempt: false }
  end

  describe 'basic behavior' do
    it 'correctly creates the object', aggregate_failures: true do
      expect(product_detail.name).to eq('Test product')
      expect(product_detail.amount).to eq(2)
      expect(product_detail.unit_price).to eq(100)
      expect(product_detail.is_imported).to eq(false)
      expect(product_detail.is_exempt).to eq(false)
    end

    it 'has expected aliases', aggregate_failures: true do
      expect(product_detail.exempt?).to eq(false)
      expect(product_detail.imported?).to eq(false)
    end

    it 'calculates total_net_price' do
      expect(product_detail.total_net_price).to eq(200)
    end
  end

  context 'when product details has no taxes' do
    it 'returns sales_tax as 0' do
      expect(product_detail.sales_tax).to eq(0)
    end

    it 'price_with_taxes equals total_net_price' do
      expect(product_detail.price_with_taxes).to eq(product_detail.total_net_price)
    end
  end

  context 'when product details has taxes'do
    before do
      product_detail.sales_tax = 10
    end

    it 'returns sales_tax' do
      expect(product_detail.sales_tax).to eq(10)
    end

    it 'total_net_price does not include taxes' do
      expect(product_detail.total_net_price).to eq(200)
    end

    it 'price_with_taxes equals total_net_price plus taxes' do
      expect(product_detail.price_with_taxes).to eq(210)
    end
  end
end