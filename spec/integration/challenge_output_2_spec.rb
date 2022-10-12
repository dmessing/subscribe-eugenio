require_relative '../../challenge'

describe Challenge do
  subject(:challenge) do
    described_class.new.call
  end

  before do
    allow($stdin).to receive(:gets).and_return(*params)
  end

  context 'Input 2' do
    let(:params) do
      [
        ['2'],
        ['imported box of chocolates', '1', '10.00', 'y', 'y'],
        ['imported bottle of perfume', '1', '47.50', 'y', 'n'],
      ].flatten
    end

    it 'returns Output 2' do
      message =
        <<~MESSAGE
        How many different products will you buy?
        Please input product name
        Please input the amount of imported box of chocolates
        Please input the unit price of imported box of chocolates
        Is the product (imported box of chocolates) imported? (Y/N)
        Is the product (imported box of chocolates) a book, food, or a medical product? (Y/N)
        Please input product name
        Please input the amount of imported bottle of perfume
        Please input the unit price of imported bottle of perfume
        Is the product (imported bottle of perfume) imported? (Y/N)
        Is the product (imported bottle of perfume) a book, food, or a medical product? (Y/N)
        1 imported box of chocolates: 10.50
        1 imported bottle of perfume: 54.65
        Sales Taxes: 7.65
        Total: 65.15
      MESSAGE

      expect { challenge }.to output(message).to_stdout
    end
  end

end
