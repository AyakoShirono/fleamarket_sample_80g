class Shipping < ApplicationRecord
  validates :fee_burden, :method, :prefecture_from, :period_before_shipping, presence: true
  belongs_to :item
end
