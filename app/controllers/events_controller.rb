class EventsController < ApplicationController
  helper_method :is_published?
  helper_method :is_publisher?
  def index
    @events = Event.where('starts_at >= :now OR user_id = :user_id', :now => Time.now, :user_id => current_user.id)
    if params[:search]
      @events = Event.search(params[:search])
    end
  end

  def new
    @event = Event.new
    @venues = Venue.all
    @categories = Category.all
  end

  def create
    @event = Event.new event_params
    @event.user_id = current_user.id
    if @event.save
      redirect_to root_path
    else
      redirect_to :back, notice: "Create Error"
    end
  end

  def published
    @event = Event.find(params[:id])
    @event.update_attribute(:published_at, Time.now)
    redirect_to event_path(@event)
  end

  def is_published?
    Event.find(params[:id]).published_at != nil
  end

  def is_publisher?
    Event.find(params[:id]).user_id == current_user.id
  end

  def show
    @event = Event.find(params[:id])
  end

  private
  def event_params
    params.require(:event).permit(:starts_at, :ends_at, :venue_id, :hero_image_url, :extended_html_description, :category_id, :name)
  end
end
