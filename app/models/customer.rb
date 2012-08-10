class Customer < ActiveRecord::Base
  has_many :transactions
  has_many :items, :through => :transactions

  attr_accessible :name

  validates :name, :presence => true
end
