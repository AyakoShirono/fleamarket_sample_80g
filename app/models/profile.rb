class Profile < ApplicationRecord
  belongs_to :user, optional: true

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :phone_number, presence: true
  validates :zip_code, presence: true
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :address, presence: true
end

