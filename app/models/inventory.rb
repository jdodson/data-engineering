class Inventory < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :item

  validates :merchant, :presence => true
  validates :merchant_id, :uniqueness => {
    :scope => :item_id,
    :message => "can not have duplicate items!"
  }

  validates :item, :presence => true
end
