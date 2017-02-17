class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Alpha Blog, #{@user.username}"
      redirect_to articles_path
      # redirect will require a rond trip new web request
      # may be render will be a better choice
    else
      render 'new'
    end
  end
    
  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end