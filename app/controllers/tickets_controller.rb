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
    if @ticket_type.save
      redirect_to new_event_tickets_path(params[:event_id]), notice: "Added successfully"
    else
      redirect_to :back, notice: "Added error"
    end
  end

  private
  def ticket_params
    params.require(:ticket_type).permit(:price, :name, :max_quantity)
  end
end
