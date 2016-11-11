require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  it "blocks unauthenticated access" do
    sign_in nil

    get :create

    expect(response).to redirect_to(login_path)
  end

  it "blocks authenticated access" do
    sign_in users(:alice)

    get :new

    expect(response).to redirect_to(login_path)
  end
end
