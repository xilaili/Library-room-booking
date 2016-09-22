class RoomsController < ApplicationController
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
  end

  def edit
  end

  def update
  end
  
  private
    def room_params
      params.require(:room).permit(:room_id, :size, :status)
    end
end
