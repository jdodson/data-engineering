class Inventory < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :item

  validates :merchant, :presence => true
  validates :item, :presence => true  
end