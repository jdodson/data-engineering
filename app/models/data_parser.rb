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
			#	puts row.class
			#	puts row.inspect
			# puts row[:purchaser_name]

				parsed_rows += 1
			end
		end

		parsed_rows
	end
end