class TicketType < ActiveRecord::Base
  belongs_to :event
  has_many :user_tickets
  validates :event_id, :price, :name, :max_quantity, presence: true
end
