class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, :nickname, :password, presence: true

  has_many :items
  has_one :profile
  has_one :card, dependent: :destroy
end
