class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # methods listed here is avalable only for controllers. But
  # to have them avalable to views use the following line
  helper_method :current_user, :logged_in?
  
  def current_user
    # Memoization is the process of storing a computed value to avoid duplicated work by future calls.
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user # !! Operator convert anything to a boolean
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
  
end
