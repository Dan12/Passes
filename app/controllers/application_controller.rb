class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :login_required, :except => [:home, :login_page, :login, :signup, :signup_page, :clear_error]
  before_filter :clear_error, :except => [:login_page, :signup_page, :edit_page]
  
  def login_required
    if session[:user_id] == nil
      session[:error_msg] = "You must log in to complete this action"
      redirect_to '/users/login_page'
    end
  end
  
  def clear_error
    session[:error_msg] = nil
  end
  
  #index
  def home
    @users = User.all
    render 'index'
  end
end
