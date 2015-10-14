class UpgraderequestController < ApplicationController
  
  #create
  def create_upreq
    if User.find_by(id: params[:admin_id]) != nil and User.find_by(id: params[:admin_id]).usertype == 3 and (params[:upgrade_type].to_i == 2 or params[:upgrade_type].to_i == 3) and UpgradeRequest.find_by(user_id: params[:user_id]) == nil and params[:upgrade_type].to_i >  User.find_by(id: params[:user_id]).usertype
      @upreq = UpgradeRequest.new
      @upreq.user_id = session[:user_id]
      @upreq.admin_id = params[:admin_id].to_i
      @upreq.upgrade_type = params[:upgrade_type].to_i
      
      if @upreq.save
        redirect_to "/users/view/#{session[:user_id]}"
      else
        redirect_to "/users/view/#{params[:admin_id]}"
      end
    else
      redirect_to "/users/view/#{params[:admin_id]}"
    end
  end
  
  #accept
  def accept_upreq
    @upreq = UpgradeRequest.find_by(id: params[:upreq_id])
    if @upreq != nil
      @admin = User.find_by(id: @upreq.admin_id)
      if @admin != nil
        @user = User.find_by(id: @upreq.user_id)
        if @user != nil
          @user.usertype = @upreq.upgrade_type
          if @user.save
            @upreq.destroy
          end
        end
      end
      redirect_to "/users/view/#{@upreq.admin_id}"
    else
      redirect_to "/"
    end
  end
end