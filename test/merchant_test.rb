require_relative 'helper_test'

require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

# Testing merchant class
class MerchantTest < MiniTest::Test
  def setup
    @data = { items:         './data/items.csv',
              merchants:     './data/merchants.csv',
              invoices:      './data/invoices.csv',
              invoice_items: './data/invoice_items.csv',
              customers:     './data/customers.csv',
              transactions:  './data/transactions.csv' }
  end

  def test_it_has_attributes
    data = {id: '5', name: 'Turing School'}
    merchant = Merchant.new(data)

    assert_equal 5, merchant.id
    assert_equal 'Turing School', merchant.name
  end

  def test_it_has_different_attributes
    data = {id: '8', name: 'Hogwarts'}
    merchant = Merchant.new(data)

    assert_equal 8, merchant.id
    assert_equal 'Hogwarts', merchant.name
    assert_instance_of Merchant, merchant
  end

  def test_if_it_returns_all_items_for_a_merchant
    sales_engine = SalesEngine.new(@data)
    id = 123_341_85
    merchant = sales_engine.merchants.find_by_id(id)

    assert_instance_of Array, merchant.items
    assert_instance_of Item, merchant.items.first
    assert_equal 6, merchant.items.length
  end

  def test_if_it_returns_all_invoices_for_a_merchant
    sales_engine = SalesEngine.new(@data)
    id = 123_341_85
    merchant = sales_engine.merchants.find_by_id(id)

    assert_instance_of Array, merchant.invoices
    assert_instance_of Invoice, merchant.invoices.first
    assert_equal 10, merchant.invoices.length
  end

  def test_if_it_returns_customers_based_on_merchants
    engine = SalesEngine.new(@data)
    expected = engine.merchants.find_by_id(123_341_94).customers

    assert_equal 12, expected.length
    assert_instance_of Customer, expected.first
  end
end
