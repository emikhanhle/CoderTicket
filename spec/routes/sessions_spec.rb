require 'rails_helper'

RSpec.describe "events", type: :routing do
  it "routes /login to sessions#new" do
    expect(get: "/login").to route_to(controller: "sessions", action: "new")
  end
end
