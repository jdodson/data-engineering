require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  test "merchants have many items through inventories" do
    bowser = merchants(:bowser)
    fire_flower = items(:fire_flower)

    assert bowser.items.include? fire_flower
    assert fire_flower.merchants.include? bowser
  end
end
