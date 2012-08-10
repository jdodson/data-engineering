require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  test "customers have many items through transactions" do
    mario = customers(:mario)
    bike = items(:bike)

    assert mario.items.include? bike
    assert bike.customers.include? mario
  end
end
