class UserTicketsController < ApplicationController
  def new
    @user_ticket = UserTicket.new
  end

  def create
    @user_ticket = UserTicket.new user_ticket_params
    @remain_tickets = remain_tickets(@user_ticket.ticket_type_id)
    if @user_ticket.quantity <= @remain_tickets
      if @user_ticket.save
        redirect_to root_path, notice: "Buy successfully"
      else
        redirect_to :back, notice: "Buy Error"
      end
    else
      redirect_to :back, notice: "Not enough ticket"
    end

  end

  private
  def user_ticket_params
    params.require(:user_ticket).permit(:user_id, :ticket_type_id, :quantity)
  end

  def remain_tickets(ticket_type_id)
    @max_quantity = TicketType.where(:id => ticket_type_id).first.max_quantity
    @total_purchased_tickets = UserTicket.where(:ticket_type_id => ticket_type_id)
    @sum = 0
    @total_purchased_tickets.each do |item|
      @sum += item.quantity
    end
    return @max_quantity - @sum
  end

end
