require 'test_helper'

class DataParserTest < ActiveSupport::TestCase
  def setup
  	@file_path = "#{Rails.root}/test/fixtures/example_input.tab"
  	@parser = DataParser.new(:path => @file_path)
  end

  test "initialization sets file" do
  	assert_equal @file_path, @parser.path
  end

  test "parse all rows" do
  	assert @parser.process > 0, "you should have all the rows parsed!"
  	assert @parser.valid?
  	assert @parser.errors.blank?
  end

  test "parse nothing" do
  	parser = DataParser.new
  	assert !parser.valid?, "should not be valid, no path!"
  	assert_equal 0, parser.process
  	assert parser.errors.present?
  end
end