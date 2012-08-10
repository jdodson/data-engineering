class Transaction < ActiveRecord::Base
  belongs_to :customer
  belongs_to :item

  attr_accessible :customer, :item, :count

  validates :count, :presence => true
  validates :count, :numericality => true

  validates :customer, :presence => true
  validates :item, :presence => true
end
