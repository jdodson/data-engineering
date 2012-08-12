require 'test_helper'

class DataParserControllerTest < ActionController::TestCase
  def setup
    @file_path = "#{Rails.root}/test/fixtures/example_input.tab"
  end

  test "index" do
    get :index

    assert :success

    assert assigns(:gross)
  end

  test "new" do
    get :new

    assert :success

    assert assigns(:parser)
  end

  test "create" do
    assert_difference('Item.count', +3) do
      assert_difference('Merchant.count', +3) do
        assert_difference('Inventory.count', +3) do
          assert_difference('Customer.count', +3) do
            assert_difference('Transaction.count', +4) do
              post :create, {
                :data_parser => {
                  :file => fixture_file_upload('/example_input.tab', 'text/plain')
                }
              }
            end
          end
        end
      end
    end

    assert_equal "Processed 4 rows", flash[:notice]
    assert_redirected_to root_path
  end

  test "create error" do
    post :create

    assert_template :new
    assert assigns(:parser).errors.present?
  end
end
