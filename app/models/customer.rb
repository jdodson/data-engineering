class Customer < ActiveRecord::Base
  has_many :transactions
  has_many :items, :through => :transactions

  validates :name, :presence => true
end
