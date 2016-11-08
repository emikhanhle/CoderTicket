class UserTicket < ApplicationRecord
  belongs_to :user
  belongs_to :ticket_type
  validates :user_id, presence: true
  validates :ticket_type_id, presence: true
  validates :quantity, presence: true
end
