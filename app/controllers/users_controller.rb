class UsersController < ApplicationController
  # index, show, new, edit, create, update and destroy
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
 
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @user = User.new
  end
  
  def edit
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Alpha Blog, #{@user.username}"
      redirect_to user_path(@user)
      # redirect will require a rond trip new web request
      # may be render will be a better choice
    else
      render 'new'
    end
  end
    
  def update
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all articles created by user have been deleted"
    redirect_to users_path
  end
    
  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
    
    def require_same_user
      if current_user != @user and !current_user.admin?
        flash[:danger] = "You can only edit your own accout"
        redirect_to root_path
      end
    end
    
    def require_admin 
      if logged_in? and !current_user.admin?
        flash[:danger] = "Only admin users can perform that action"
        redirect_to root_path
      end
    end
end