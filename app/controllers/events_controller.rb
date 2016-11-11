class EventsController < ApplicationController
  helper_method :is_published?
  helper_method :is_publisher?
  def index
    @events = Event.where('starts_at >= :now', :now => Time.now).where.not("published_at" => nil)
    if current_user
      @events = Event.where('starts_at >= :now OR user_id = :user_id', :now => Time.now, :user_id => current_user.id)
    end
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
    if has_ticket_type(@event)
      @event.update_attribute(:published_at, Time.now)
      redirect_to event_path(@event), notice: "Published event #{@event.name}"
    else
      redirect_to event_path(@event), notice: "Does not have any ticket types"
    end
  end

  def is_published?
    Event.find(params[:id]).published_at != nil
  end

  def is_publisher?
    if logged_in?
     return true if Event.find(params[:id]).user_id == current_user.id
   else
     return false
   end
  end

  def show
    @event = Event.find(params[:id])
  end

  def mine
    if logged_in?
      @events = Event.where('user_id = :user_id', :now => Time.now, :user_id => current_user.id)
    else
      redirect_to login_path
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes! event_params
      redirect_to event_path(@event), notice: "Update successfully"
    else
      render 'edit', notice: "update failed"
    end
  end

  private
  def event_params
    params.require(:event).permit(:starts_at, :ends_at, :venue_id, :hero_image_url, :extended_html_description, :category_id, :name)
  end

  def has_ticket_type(event)
    return true if event.ticket_types.count > 0
  end
end
