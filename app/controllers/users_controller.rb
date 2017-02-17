class UsersController < ApplicationController
  # index, show, new, edit, create, update and destroy
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
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
    
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end
    
  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end