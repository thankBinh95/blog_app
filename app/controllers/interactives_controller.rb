class InteractivesController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find params[:followed_id]
    current_user.follow(@user)
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Interactive.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  private

  def logged_in_user
    return if logged_in?
    flash.now[:danger] = t ".flash_update_dg"
    redirect_to login_url
  end
end
