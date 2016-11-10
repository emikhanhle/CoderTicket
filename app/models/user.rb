class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: {case_insensitive: false}
  has_secure_password
  has_many :user_tickets
  has_many :events
end
