class UsersController < ApplicationController
  before_action :authorize
  def index
    @users = User.all.paginate(page: params[:page], per_page: 5)
  end
  
  def create
    @user = User.new(user_params)
    puts user_params[:userType]
    if(user_params[:userType] == 'a')
      @user.userType = 'Admin'
    else
      @user.userType = 'User' 
    end
    if @user.save
      flash[:notice] = "Account created successfully!"
      redirect_to root_path
    else
      flash.now.alert = "Oops, couldn't create account. Please make sure you are using a valid email and password and try again."
      redirect_to users_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    if params[:option].blank?
      @user = User.new
    else
      @user = User.new(session[:user])
      session.delete(:user)
    end
  end

  def registerConfirm
    @user = User.new(user_params);
    if(@user.userType == 'a')
      @user.userType = 'Admin'
    else
      @user.userType = 'User'
    end
    session[:user] = user_params
    render 'confirmRegister'
  end

  def edit
  end

  def profile
    id = session[:user_id]
    @user = User.find(id)
  end

  def editProfile
    @user = User.find(session[:user_id])
  end

  def changePassword
      @user = User.find_by_email(params[:email])
    
  end

  def updatePassword
    @user = User.find_by_email(user_params[:email])
      puts 'changePasswoerd'
      msg = User.checkForgetPassword(user_params[:oldPassword], user_params[:newPassword], user_params[:confirmPassword])
      if  msg == ""
        @user.password_digest = user_params[:newPassword]
        if @user.save
          flash[:notice] = "Successfully change password!"
          if !current_user.blank?
            puts 'current_user'
            session.delete(:user_id)
          end
          redirect_to root_path
        end
      else
        flash[:alert] = msg
        render :forgetPassword
      end
end

  def update
    @user = User.find(session[:user_id])
    if(@user.userType == 'a')
      @user.userType = 'Admin'
    else
      @user.userType = 'User'
    end
    if @user.update(user_params)
      redirect_to users_path
    else
      render 'editProfile'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  
    redirect_to user_path, status: :see_other
  end
  
  private
  def user_params
    params.require(:user).permit( :name, :email, :password, :userType, :phone, :dob, :address, :profile)
  end

end
