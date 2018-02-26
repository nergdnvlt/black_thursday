require 'CSV'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'

# Creates a sales engine class to tie everything together
class SalesEngine
  attr_reader :item_csv,
              :merchant_csv,
              :invoices_csv,
              :customers_csv,
              :items,
              :merchants,
              :invoices,
              :invoice_items,
              :customers

  def initialize(data)
    @item_csv          = data[:items]
    @merchant_csv      = data[:merchants]
    @invoices_csv      = data[:invoices]
    @invoice_items_csv = data[:invoice_items]
    @customers_csv     = data[:customers]
    @items             = ItemRepository.new(@item_csv, self)
    @merchants         = MerchantRepository.new(@merchant_csv, self)
    @invoices          = InvoiceRepository.new(@invoices_csv, self)
    @invoice_items     = InvoiceItemRepository.new(@invoice_items_csv, self)
    @customers         = CustomerRepository.new(@customers_csv, self)
  end

  def self.from_csv(data)
    new(data)
  end

  def find_merchant(id)
    @merchants.find_by_id(id)
  end

  def find_items_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant_by_merchant_id(id)
    @merchants.find_by_id(id)
  end

  def find_invoices_by_merchant_id(id)
    @invoices.find_all_by_merchant_id(id)
  end

  def find_invoice(invoice_id)
    @invoices.find_by_id(invoice_id)
  end

  def find_invoice_items_by_invoice_id(id)
    @invoice_items.find_all_by_invoice_id(id)
  end

  def find_item_by_id(item_id)
    @items.find_by_id(item_id)
  end
end
