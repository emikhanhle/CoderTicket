class VenuesController < ApplicationController
  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new venue_params
    if @venue.save
      redirect_to root_path, notice: "New venue added"
    else
      render 'new', notice: "Added venue error"
    end
  end

  private
  def venue_params
    params.require(:venue).permit(:name, :full_address, :region_id)
  end
end
