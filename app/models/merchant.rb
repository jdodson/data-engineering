class Merchant < ActiveRecord::Base
  has_many :inventories
  has_many :items, :through => :inventories

  attr_accessible :name, :address

  validates :name, :presence => true
end
