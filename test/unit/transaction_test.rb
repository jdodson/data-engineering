require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test "Transaction.gross, no transactions no gross" do
    Transaction.destroy_all

    assert_equal 0.0, Transaction.gross
  end

  test "Transaction.gross add up a few purchases" do
    mario = customers(:mario)

    Transaction.create(
      :customer => mario,
      :item => items(:fire_flower),
      :count => 2
    )

    assert_equal 14.82, Transaction.gross
  end
end