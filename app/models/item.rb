class Item < ApplicationRecord
  validates :name, :price, :detail, :condition, :category_id, :size_id, presence: true
  validates :images, length: { minimum: 1, maximum: 5}

  belongs_to :user, foreign_key: 'user_id'
  has_many :images, dependent: :destroy
  has_one :shipping, dependent: :destroy
  belongs_to :category

  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :shipping, allow_destroy: true

  validates_associated :images
  validates :images, presence: true
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :prefecture
    belongs_to :user, optional: true
end

