require_relative '../../challenge'

describe Challenge do
  subject(:challenge) do
    described_class.new.call
  end

  before do
    allow($stdin).to receive(:gets).and_return(*params)
  end

  context 'Input 3' do
    let(:params) do
      [
        ['4'],
        ['imported bottle of perfume', '1', '27.99', 'y', 'n'],
        ['bottle of perfume', '1', '18.99', 'n', 'n'],
        ['packet of headache pills', '1', '9.75', 'n', 'y'],
        ['imported box of chocolates', '3', '11.25', 'y', 'y']
      ].flatten
    end

    it 'returns Output 3' do
      message =
        <<~MESSAGE
        How many different products will you buy?
        Please input product name
        Please input the amount of imported bottle of perfume
        Please input the unit price of imported bottle of perfume
        Is the product (imported bottle of perfume) imported? (Y/N)
        Is the product (imported bottle of perfume) a book, food, or a medical product? (Y/N)
        Please input product name
        Please input the amount of bottle of perfume
        Please input the unit price of bottle of perfume
        Is the product (bottle of perfume) imported? (Y/N)
        Is the product (bottle of perfume) a book, food, or a medical product? (Y/N)
        Please input product name
        Please input the amount of packet of headache pills
        Please input the unit price of packet of headache pills
        Is the product (packet of headache pills) imported? (Y/N)
        Is the product (packet of headache pills) a book, food, or a medical product? (Y/N)
        Please input product name
        Please input the amount of imported box of chocolates
        Please input the unit price of imported box of chocolates
        Is the product (imported box of chocolates) imported? (Y/N)
        Is the product (imported box of chocolates) a book, food, or a medical product? (Y/N)
        1 imported bottle of perfume: 32.19
        1 bottle of perfume: 20.89
        1 packet of headache pills: 9.75
        3 imported box of chocolates: 35.55
        Sales Taxes: 7.90
        Total: 98.38
      MESSAGE

      expect { challenge }.to output(message).to_stdout
    end
  end

end
