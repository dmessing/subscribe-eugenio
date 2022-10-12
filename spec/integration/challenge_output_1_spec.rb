require_relative '../../challenge'

describe Challenge do
  subject(:challenge) do
    described_class.new.call
  end

  before do
    allow($stdin).to receive(:gets).and_return(*params)
  end

  context 'Input 1' do
    let(:params) do
      [
        ['3'],
        ['book', '2', '12.49', 'n', 'y'],
        ['music CD', '1', '14.99', 'n', 'n'],
        ['chocolate bar', '1', '0.85', 'n', 'y']
      ].flatten
    end

    it 'returns Output 1' do
      message =
        <<~MESSAGE
        How many different products will you buy?
        Please input product name
        Please input the amount of book
        Please input the unit price of book
        Is the product (book) imported? (Y/N)
        Is the product (book) a book, food, or a medical product? (Y/N)
        Please input product name
        Please input the amount of music CD
        Please input the unit price of music CD
        Is the product (music CD) imported? (Y/N)
        Is the product (music CD) a book, food, or a medical product? (Y/N)
        Please input product name
        Please input the amount of chocolate bar
        Please input the unit price of chocolate bar
        Is the product (chocolate bar) imported? (Y/N)
        Is the product (chocolate bar) a book, food, or a medical product? (Y/N)
        2 book: 24.98
        1 music CD: 16.49
        1 chocolate bar: 0.85
        Sales Taxes: 1.50
        Total: 42.32
      MESSAGE

      expect { challenge }.to output(message).to_stdout
    end
  end

end
