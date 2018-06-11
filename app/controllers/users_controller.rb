class UsersController < ApplicationController
  before_action :find_user, only: %i(show edit update destroy)
  before_action :logged_in_user, only:
    %i(edit update destroy following followers)
  before_action :correct_user, only: %i(edit update)

  def index
    @users = User.order_name.paginate(page: params[:page],
      per_page: 10)
  end

  def show
    @entries = @user.entries.order_entry.paginate(page: params[:page],
      per_page: 10)
  end

  def new
    @user = User.new
  end

 def update
    if @user.update_attributes user_params
      flash[:success] = t ".flash_update_sc"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".flash_success_del"
    else
      flash[:danger] = t ".flash_fail_del"
    end
    redirect_to users_url
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".flash_create_success"
      redirect_to root_url
    else
      render :new
    end
  end

  def following
    @title = t "users.following"
    @user = User.find_by id: params[:id]
    @users = @user.following.paginate page: params[:page]
    render "show_follow"
  end

  def followers
    @title = t "users.follower"
    @user = User.find_by id: params[:id]
    @users = @user.followers.paginate page: params[:page]
    render "show_follow"
  end

  private

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".flash_user_nfound"
    redirect_to users_path
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    flash.now[:danger] = t ".flash_pl_login"
    redirect_to login_url
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to(root_url) unless current_user?(@user)
  end
end
