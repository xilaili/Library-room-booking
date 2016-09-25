class HistoriesController < ApplicationController
  before_action :admin_user, only: [:new, :create, :index, :show]
  before_action :pre_admin_user,     only: [:destroy]
  def index
    @histories = History.paginate(page: params[:page])
  end

  def new
    @history = History.new
  end

  def create
    @history = History.new(history_params)    # not finised
    if !Room.exists?(room_id: @history.room_id)
      flash[:danger] = "Room not exists"
      render 'new' and return
    end
    if !User.exists?(email: @history.user_email)
      flash[:danger] = "User not exists"
      render 'new' and return
    end
    if @history.startTime.to_time > Time.now+7.days
      flash[:danger] = "booking up to 7 days ahead"
      render 'new' and return 
    end
    @history.startTime = @history.startTime.to_time + 0.minutes
    @history.endTime = @history.startTime.to_time + 2.hours
    
    #check availability
    @hists = History.where(room_id: @history.room_id)
    @hists.each do |h|
        if h.startTime<@history.startTime and h.endTime>@history.startTime
          flash[:danger] = "Conflict"
          render 'new' and return
        end
        if h.startTime>@history.startTime and h.startTime<@history.endTime
          flash[:danger] = "Conflict"
          render 'new' and return 
        end
    end
    
    if @history.save
      flash[:success] = "The history has been created"
      redirect_to @history
    else
      flash[:danger] = "not created"
      render 'new'
    end
  end

  def show
     @history = History.find(params[:id])
  end
  
  def destroy
    History.find(params[:id]).destroy
    flash[:success] = "History deleted"
    redirect_to histories_url
  end
  
  private
    def history_params
      params.require(:history).permit(:user_email, :room_id, :startTime, :endTime)
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
    def pre_admin_user
      redirect_to(root_url) unless current_user.admin? and current_user.pre_admin?
    end
end
