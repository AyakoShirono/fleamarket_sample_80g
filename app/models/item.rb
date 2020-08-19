class Item < ApplicationRecord
  validates :name, :price, :detail, :condition, :category_id, :size_id, presence: true

  belongs_to :user, foreign_key: 'user_id'
  has_many :images
  has_one :shipping
  belongs_to :category

  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :shipping, allow_destroy: true

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :prefecture
    belongs_to :user, optional: true
    # validates :prefecture, presence: true
end

