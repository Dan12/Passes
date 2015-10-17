class UserController < ApplicationController
  
  #create and login
  def login_page
    render 'login'
  end
  
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      session[:error_msg] = nil
      redirect_to "/"
    else
      if !@user
        session[:error_msg] = "Email not found"
      else
        session[:error_msg] = "Wrong password"
      end
      redirect_to "/users/login_page"
    end
  end
  
  def logout
    reset_session
    redirect_to '/'
  end
  
  def signup_page
    render 'signup'
  end
  
  def signup
    if params[:username] == nil or params[:username] == ""
      session[:error_msg] = "Enter your name"
      redirect_to "/users/signup"
    elsif params[:email] == nil or params[:email] == ""
      session[:error_msg] = "Enter an email"
      redirect_to "/users/signup"
    elsif (params[:email].include? "@") == false
      session[:error_msg] = "Enter a valid email"
      redirect_to "/users/signup"
    elsif params[:password] == nil or params[:password] == ""
      session[:error_msg] = "Enter a password"
      redirect_to "/users/signup"
    elsif params[:password_confirmation] == nil or params[:password_confirmation] == ""
      session[:error_msg] = "Validate your password"
      redirect_to "/users/signup"
    else
      @user = User.new
      @user.username = params[:username]
      @user.email = params[:email]
      @user.password = params[:password]
      @user.password_confirmation = params[:password_confirmation]
      @user.usertype = 1
      
      if @user.save
        session[:user_id] = @user.id
        session[:error_msg] = nil
        redirect_to "/users/view/#{@user.id}"
      else
        if @user.password == @user.password_confirmation
          session[:error_msg] = "Password and Confimation don't match"
        else
          session[:error_msg] = "Email already in use"
        end
        redirect_to "/users/signup"
      end
    end
  end
  
  #view
  def view
    @user = User.find_by(id: params[:id])
    if @user != nil
      @visiting_user = User.find_by(id: session[:user_id])
      render 'view'
    else
      redirect_to '/'
    end
  end
  
  #edit
  def edit_page
    if params[:id].to_s == session[:user_id].to_s
      @user = User.find_by(id: session[:user_id])
      if @user != nil
        render "edit"
      else
        redirect_to '/'
      end
    else
      redirect_to "/users/view/#{params[:id]}"
    end
  end
  
  def update
    if params[:id].to_s == session[:user_id].to_s
      @user = User.find_by(id: session[:user_id])
      if @user != nil
        if params[:username] != nil and params[:username] != ""
          @user.username = params[:username]
        end
        if params[:email] != nil and params[:email] != ""
          @user.email = params[:email]
        end
        @user.password = params[:password]
        @user.password_confirmation = params[:password_confirmation]
        
        if @user.save
          session[:error_msg] = nil
          redirect_to "/users/view/#{params[:id]}"
        else
          if @user.password == @user.password_confirmation
            session[:error_msg] = "Password and Confimation don't match"
          else
            session[:error_msg] = "Email taken"
          end
          redirect_to "/users/edit/#{@user.id}"
        end
      else
        redirect_to '/'
      end
    else
        redirect_to "/users/view/#{params[:id]}"
    end
  end
  
  #change
  def changeStatus
    @user = User.find_by(id: session[:user_id])
    if @user.usertype == 3
      @change_user = User.find_by(id: params[:user_id])
      if @change_user != nil and @change_user.usertype != 3
        @change_user.usertype = params[:change_type].to_i
        @change_user.save
      end
    end
    redirect_to "/users/view/#{params[:user_id]}"
  end
  
  #destroy
  def destroy
    reset_session
    redirect_to '/'
  end
end