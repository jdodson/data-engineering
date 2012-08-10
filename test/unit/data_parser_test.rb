require 'test_helper'

class DataParserTest < ActiveSupport::TestCase
  def setup
    @file_path = "#{Rails.root}/test/fixtures/example_input.tab"
    @parser = DataParser.new(:path => @file_path)
  end

  test "initialization sets file" do
    assert_equal @file_path, @parser.path
  end

  test "parse nothing" do
    parser = DataParser.new
    assert !parser.valid?, "should not be valid, no path!"
    assert_equal 0, parser.process
    assert parser.errors.present?
  end

  test "process responds correctly" do
    assert @parser.process > 0, "you should have all the rows parsed!"

    assert @parser.valid?
    assert @parser.errors.blank?
  end

  test "process and ensure correct inserts" do
    assert_difference('Item.count', +3) do
      assert_difference('Merchant.count', +3) do
        assert_difference('Inventory.count', +3) do
          assert_difference('Customer.count', +3) do
            assert_difference('Transaction.count', +4) do
              assert @parser.process
            end
          end
        end
      end
    end
  end

  test "process curbs against possible duplicate entries" do
    @parser.process

    assert_equal 1, Customer.where(:name => "Snake Plissken").count
    assert_equal 1, Item.where(:name => "$20 Sneakers for $5").count
    assert_equal 1, Merchant.where(:name => "Sneaker Store Emporium").count
  end

  test "process and ensure customers items come out properly" do
    @parser.process

    amy = Customer.find_by_name "Amy Pond"
    marty = Customer.find_by_name "Marty McFly"
    snake = Customer.find_by_name "Snake Plissken"

    assert_equal 2, snake.items.size
    assert_equal 1, marty.items.size
    assert_equal 1, amy.items.size

    assert Item.find_by_name "$10 off $20 of food"
    assert Item.find_by_name "$30 of awesome for $10"
    assert Item.find_by_name "$20 Sneakers for $5"

    assert Merchant.find_by_name "Bob's Pizza"
    assert Merchant.find_by_name "Tom's Awesome Shop"
    assert Merchant.find_by_name "Sneaker Store Emporium"
  end
end
