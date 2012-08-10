class Merchant < ActiveRecord::Base
  has_many :inventories
  has_many :items, :through => :inventories

  validates :name, :presence => true  
end