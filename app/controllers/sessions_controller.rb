class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      log_in user
      check_remember user
      flash[:success] = t ".login_sucess"
      redirect_back_or user
    else
      flash[:danger] = t ".err_login"
      redirect_to login_path
    end
  end

  def destroy
    log_out
    flash[:success] = t ".log_uot_success"
    redirect_to root_url
  end

  def check_remember user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
  end
end
