class CreateUserTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :user_tickets do |t|
      t.references :user, foreign_key: true
      t.references :ticket_type, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
