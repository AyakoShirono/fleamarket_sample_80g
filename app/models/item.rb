class Item < ApplicationRecord
  validates :name, :price, :detail, :condition, :category_id, :size_id, presence: true

  has_many :images
  has_one :shipping

  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :shipping, allow_destroy: true

end
