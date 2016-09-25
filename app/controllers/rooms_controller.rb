class RoomsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy, :edit, :update]
  before_action :admin_user,     only: [:new, :create, :destroy]
  def index
    @rooms = Room.paginate(page: params[:page])
  end
  
  def show
    @room = Room.find(params[:id])
  end
  
  def new
    @room = Room.new
  end
  
  def create
    @room = Room.new(room_params)    # not finised
    if @room.save
      flash[:success] = "The room has been created"
      redirect_to @room
    else
      render 'new'
    end
  end

  def destroy
    Room.find(params[:id]).destroy
    flash[:success] = "Room deleted"
    redirect_to rooms_url
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find_by(room_id: params[:rid])
    @history = History.new
    @history.user_email = current_user.email
    @history.room_id = params[:rid]
    @history.startTime = params[:start_time][0].to_time
    @history.endTime = params[:start_time][0].to_time + 2.hours
    if @history.startTime > Time.now+7.days
      flash[:danger] = "booking up to 7 days ahead"
      redirect_to @room and return
    end
    
    @hists = History.where(room_id: @history.room_id)
    @hists.each do |h|
        if h.startTime<@history.startTime and h.endTime>@history.startTime
          flash[:danger] = "Conflict"
          redirect_to @room and return
        end
        if h.startTime>@history.startTime and h.startTime<@history.endTime
          flash[:danger] = "Conflict"
          redirect_to @room and return
        end
    end
    
    if @history.save
      flash[:success] = "The room has been booked"
      redirect_to @room
    else
      flash[:danger] = "Something wrong: the room not booked successfully"
      redirect_to @room
    end

=begin
    @room = Room.find_by_id(params[:id])
    if @room.update_attributes(room_params)
      if @room.status==true
          flash[:success] = "have booked"
          redirect_to @room
      else
          flash[:success] = "not booked "
          redirect_to @room
      end
    else
      render 'edit'
    end
=end
  end
  
  private
    def room_params
      params.require(:room).permit(:room_id, :size, :status)
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
end
