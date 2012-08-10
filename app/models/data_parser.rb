require 'csv'

class DataParser
  include ActiveModel::Validations

  attr_accessor :path

  validates :path, :presence => true

  def initialize(attributes = {})
    attributes.each { |key, val| send("#{key}=", val) if respond_to?("#{key}=") }
  end

  def process
    parsed_rows = 0

    if valid?
      CSV.foreach(self.path, {:headers => true, :header_converters => :symbol, :col_sep => "\t", :skip_blanks => true}) do |row|

        ActiveRecord::Base.transaction do
          item = Item.find_or_create_by_name(
            :name => row[:item_description],
          :price => row[:item_price]
          )

          merchant = Merchant.find_or_create_by_name(
            :name => row[:merchant_name],
            :address => row[:merchant_address]
          )

          merchant.items << item unless merchant.items.include? item

          customer = Customer.find_or_create_by_name(
          :name => row[:purchaser_name]
          )

          transaction = Transaction.create(
            :customer => customer,
            :item => item,
            :count => row[:purchase_count].to_i
          )

          parsed_rows += 1
        end
      end
    end

    parsed_rows
  end
end