class Item < ApplicationRecord
  validates :name, :price, :detail, :condition, :category_id, :size_id, presence: true

  has_many :images
  has_one :shipping
  # , optional: trueはいらない
  accepts_nested_attributes_for :images, :shipping, allow_destroy: true
end
