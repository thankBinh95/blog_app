class EntriesController < ApplicationController
  before_action :find_entries, only: %i(show edit update destroy)

  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.build(entries_params)
    if @entry.save
      flash[:success] = "entry.flash_create_success"
      redirect_to current_user
    else
      flash.now[:danger] = "entry.flash_create_failse"
      render :new
    end
  end

  private

  def find_entries
    @entry = Entry.find_by id: params[:id]
    return if @entry
    flash[:danger] = t "entry.flash_entry_nfound"
    redirect_to users_path
  end

  def entries_params
    params.require(:entry).permit :content, :title
  end
end
