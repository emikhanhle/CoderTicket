class UsersController < ApplicationController
  # before_action :authenticate_user!
  include SessionsHelper

  def index
    redirect_to login_path if !logged_in?
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render "new"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
