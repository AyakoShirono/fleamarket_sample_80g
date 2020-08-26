class Item < ApplicationRecord
  validates :name, :price, :detail, :condition, :category_id, :size_id, presence: true
  validates :images, length: { minimum: 1, maximum: 5}
  validates :name, length: {maximum:40}
  validates :price,numericality: { only_integer: true, greater_than: 300, less_than: 999999}

  belongs_to :user, foreign_key: 'user_id'
  has_many :images, dependent: :destroy
  has_one :shipping, dependent: :destroy
  belongs_to :category

  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :shipping, allow_destroy: true

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :prefecture
    belongs_to :user, optional: true
end

