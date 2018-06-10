class StaticPagesController < ApplicationController
  def home
    if logged_in?
      current_user = @current_user
    else
      current_user = User.first
    end
  @entry = current_user.entries.build
  @feed_items = current_user.feed.paginate page: params[:page], per_page: 10
end

  def help; end

  def about; end

  def contact; end
end
