class User < ApplicationRecord
  has_many :products, dependent: :destroy
  has_secure_password

  validates :user_name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
