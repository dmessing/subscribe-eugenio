require_relative './product_detail'

class ReceiptDetails
  def call
    amount_of_different_products.times.map do
      product_data
    end
  end

  def product_data
    current_product_name = product_name
    amount = amount_of_product(current_product_name)
    unit_price = unit_price_of_product(current_product_name)
    is_imported = imported?(current_product_name)
    is_exempt = exempt_from_sales_tax?(current_product_name)

    ProductDetail.new(name: current_product_name, amount: amount, unit_price: unit_price,
                      is_imported: is_imported, is_exempt: is_exempt)
  end

  def amount_of_different_products
    puts "How many different products will you buy?"
    $stdin.gets.chomp.to_i
  end

  def product_name
    puts "Please input product name"
    $stdin.gets.chomp
  end

  def amount_of_product(product)
    puts "Please input the amount of #{product}"
    $stdin.gets.chomp.to_i
  end

  def unit_price_of_product(product)
    puts "Please input the unit price of #{product}"
    $stdin.gets.chomp.to_f
  end

  def imported?(product_name)
    puts "Is the product (#{product_name}) imported? (Y/N)"
    $stdin.gets.chomp.upcase == 'Y'
  end

  def exempt_from_sales_tax?(product_name)
    puts "Is the product (#{product_name}) a book, food, or a medical product? (Y/N)"
    $stdin.gets.chomp.upcase == 'Y'
  end
end

