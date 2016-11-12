class TicketsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
  end

  def new
    @event = Event.find(params[:event_id])
  end

  def create
    @ticket_type = TicketType.new ticket_params
    @ticket_type.event_id = params[:event_id]
    case
    when exist_price?(@ticket_type)
      redirect_to :back, notice: "price existed"
    when exist_max_quantity?(@ticket_type)
      redirect_to :back, notice: "max quantity existed"
    else
      if @ticket_type.save
        redirect_to new_event_ticket_path(params[:event_id]), notice: "Added successfully"
      else
        redirect_to :back, notice: "Added error"
      end
    end
  end

  private
  def ticket_params
    params.require(:ticket_type).permit(:price, :name, :max_quantity)
  end

  def exist_tickets
    TicketType.where(:event_id => params[:event_id])
  end

  def exist_price?(new_ticket)
    exist_tickets.each do |ticket|
      return true if ticket.price == new_ticket.price
    end
    return false
  end

  def exist_max_quantity?(new_ticket)
    exist_tickets.each do |ticket|
      return true if ticket.max_quantity == new_ticket.max_quantity
    end
    return false
  end
end
