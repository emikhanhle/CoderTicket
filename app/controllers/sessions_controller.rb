class SessionsController < ApplicationController
  include SessionsHelper

  def new
    redirect_to root_path if logged_in?
  end

  def create
    if @user = User.find_by_email(params[:email])
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to root_path
      else
        redirect_to login_path, notice: "Password is not correct"
      end
    else
      redirect_to login_path, notice: "Email is not correct"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
