class HistoriesController < ApplicationController
  before_action :admin_user, only: [:index, :show]
  def index
    @histories = History.paginate(page: params[:page])
  end

  def new
    @history = History.new
  end

  def create
    @history = History.new(history_params)    # not finised
    @history.startTime = @history.startTime.to_time + 0.minutes
    @history.endTime = @history.endTime.to_time + 0.minutes
    # need some constraints here. only one booking per day.... , if xbm@qq.com is in user list

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
    
    #check availability
    @hists = History.where(room_id: @history.room_id)

    @hists.each do |h|
      if h.startTime<=@history.startTime and h.endTime>@history.startTime
        flash[:danger] = "Conflict"
        render 'new' and return
      end
      if h.startTime<@history.endTime and h.endTime>=@history.endTime
        flash[:danger] = "Conflict"
        render 'new' and return 
      end
    end
    
    if @history.save
      flash[:success] = "The history has been created"
      if current_user.admin? 
        redirect_to histories_url
      else 
        redirect_to current_user
      end
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
    redirect_to current_user
  end
  
  def search
    @rooms = []
    if params.has_key?(:start_time)
      @size = params[:size]
      @building = params[:building]
      @search_start_time = DateTime.new(params[:start_time]['year'].to_i ,params[:start_time]['month'].to_i ,params[:start_time]['day'].to_i ,params[:start_time]['hour'].to_i ,00,00)
      @search_end_time = @search_start_time + 2.hours
=begin
      subquery = Room.joins("LEFT OUTER JOIN histories on rooms.room_id = histories.room_id").where("((? >= histories.startTime AND ? < histories.endTime ) OR ( ? > histories.startTime AND ? <= histories.endTime ))", @search_start_time, @search_start_time, @search_end_time, @search_end_time).distinct.select('rooms.room_id')
=end
      subquery = []
      History.all.each do |h|
        if h.startTime<=@search_start_time and h.endTime>@search_start_time
          subquery.push(h.room_id)
        end
        if h.startTime<@search_end_time and h.endTime>=@search_end_time
          subquery.push(h.room_id)
        end
      end
      if subquery==[]
        @rooms = Room.all
      elsif @size != 'Any' and @building != 'Any'
        @rooms = Room.where(" room_id not in (?)", subquery).where(" size = ?", @size).where(" building = ?", @building)
      elsif @size != 'Any'
        @rooms = Room.where(" room_id not in (?)", subquery).where(" size = ?", @size)
      elsif @building != 'Any'
        @rooms = Room.where(" room_id not in (?)", subquery).where(" building = ?", @building)
      else
        @rooms = Room.where(" room_id not in (?)", subquery)
      end
      #@rooms = Room.where("room_id in (?)", subquery)
      #@rooms = Room.all
      #@rooms = subquery
    end
  end
  
  def roomhistory
    @room = Room.find(params[:id])
    @histories = History.where(room_id: @room.room_id).order(:startTime)
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
