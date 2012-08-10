class Item < ActiveRecord::Base
  has_many :transactions
  has_many :customers, :through => :transactions

  has_many :inventories
  has_many :merchants, :through => :inventories

  attr_accessible :name, :price

  validates :name, :presence => true
  validates :price, :presence => true
  validates :price, :numericality => true
end
