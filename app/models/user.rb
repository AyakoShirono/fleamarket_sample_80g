class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, :nickname, :password, presence: true

  # has_many :products
  has_one :profile
end
