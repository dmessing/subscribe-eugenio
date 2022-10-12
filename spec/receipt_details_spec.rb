require 'spec_helper'
require_relative '../app/receipt_details'
require_relative '../app/product_detail'

describe ReceiptDetails do
  subject(:receipt_details) do
    described_class.new.call
  end

  before do
    allow($stdin).to receive(:gets).and_return(*params)
    allow(ProductDetail).to receive(:new).and_return(product_detail)
  end

  after do
    RSpec::Mocks.space.proxy_for($stdin).reset
  end

  let(:product_detail) do
    instance_double(ProductDetail)
  end

  let(:params)do
    ['1', 'book', '2', '12.49', 'n', 'y']
  end

  it 'asks expected questions' do
    message = "How many different products will you buy?\n" + "Please input product name\n" +
              "Please input the amount of book\n" + "Please input the unit price of book\n" +
              "Is the product (book) imported? (Y/N)\n" +
              "Is the product (book) a book, food, or a medical product? (Y/N)\n"
    expect { receipt_details }.to output(message).to_stdout
  end

  it 'creates expected object' do
    receipt_details
    expected_params = { name: 'book', amount: 2, unit_price: 12.49, is_imported: false,
                        is_exempt: true }
    expect(ProductDetail).to have_received(:new).with(expected_params)
  end
end

