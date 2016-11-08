class EventsController < ApplicationController
  def index
    @events = Event.where('starts_at >= :now', :now => Time.now)
    if params[:search]
      @events = Event.search(params[:search])
    end
  end

  def new
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
  end
end
