class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy, :show]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :upgrade, :downgrade]
  def new
    @user = User.new
  end
  
  def adminlist
    list=User.where(:admin => true)
    @users=list.paginate(page: params[:page])
  end
  
  def index
    if current_user.admin?
       list=User.where(:admin => false)
       @users=list.paginate(page: params[:page])
    else
      flash[:fail] = "Permission denied"
      redirect_to current_user
    end
  end
  
  def show
    @user = User.find(params[:id])
    
    if current_user?(@user) or current_user.admin?
      @user
    else
      flash[:fail] = "Permission denied"
      redirect_to current_user
    end
    
  end
  
  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      if current_user.nil?
         log_in @user
         redirect_to @user
         flash[:success] = "Welcome to the Sample App!"
      else
        redirect_to @user
         flash[:success] = "create the user"
      end
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
      @user = User.find(params[:id])
      his = History.where(user_email: @user.email)
      flag = false
      for i in his
        if i.endTime>=Time.now-3.hours
          flag = true
          break
        end
      end
      if flag
        flash[:danger] = "This user has pending reservations, please cancel the booking before delete the user"
        redirect_to users_url and return 
      end
      @user.destroy
      flash[:success] = "User deleted"
      redirect_to users_url
  end
  
  def downgrade
    @user = User.find(params[:id])
    @user.admin = false
    @user.save
    if !@user.admin?
      flash[:success] = "#{@user.name}"+" "+"removed from admin"
    end
    redirect_to users_url
  end
  
  def upgrade
    @user = User.find(params[:id])
    @user.admin = true
    @user.save
    if @user.admin?
      flash[:success] = "#{@user.name}"+" "+"added to admin"
    end
    redirect_to users_url
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :admin)
    end
    
    def admin_params
      params.require(:user).permit(:admin)
    end
    
    def logged_in_user
      unless logged_in?
        #store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        redirect_to(users_url) 
        flash[:danger] = "Permission denied."
      end
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
