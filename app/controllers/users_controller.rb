class UsersController < ApplicationController
  before_action :find_user, only: %i(show edit update destroy)

  def index
    @users = User.order_name
  end

  def show
    @entries = @user.entries.order_entry.paginate(page: params[:page],
      per_page: 10)
  end

  def new
    @user = User.new
  end

  def edit; end

  def update; end

  def destroy; end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".flash_create_success"
      redirect_to root_url
    else
      render :new
    end
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
end
