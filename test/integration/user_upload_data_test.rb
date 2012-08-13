require 'test_helper'

class UserUploadDataTest < ActionDispatch::IntegrationTest
  def setup
    @file = Rack::Test::UploadedFile.new("#{Rails.root}/test/fixtures/example_input.tab", "text/plain")
  end

  test "no transactions, no gross" do
    Transaction.destroy_all

    find_no_profit
  end

  test "upload file, directs you back to view gross" do
    Transaction.destroy_all

    get new_data_parser_path
    assert_response :success

    post data_parser_index_path, {
      :data_parser => {
        :file => @file
      }
    }

    assert_redirected_to root_path
    follow_redirect!

    assert_select ".notice", "Processed 4 rows"
    assert_select ".gross_profit", "Gross Profit: $95.00"
  end

  test "upload file is empty, error messages displayed" do
    Transaction.destroy_all

    get new_data_parser_path
    assert_response :success

    post data_parser_index_path, {
      :data_parser => {
        :file => nil
      }
    }

    assert_template :new
    assert_select "li", "File can't be blank"

    find_no_profit
  end

  private

  def find_no_profit
    get root_path
    assert :success
    assert_select ".gross_profit", "Gross Profit: $0.00"
  end
end
