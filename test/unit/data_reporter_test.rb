require 'test_helper'

class DataReporterTest < ActiveSupport::TestCase
  test "DataReporter.gross, no transactions no gross" do
    Transaction.destroy_all

    assert_equal 0.0, DataReporter.gross
  end

  test "DataReporter.gross add up a few purchases" do
    mario = customers(:mario)

    Transaction.create(
      :customer => mario,
      :item => items(:fire_flower),
      :count => 2
    )

    assert_equal 14.82, DataReporter.gross
  end
end