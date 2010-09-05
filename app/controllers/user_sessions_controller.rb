class UserSessionsController < ApplicationController
  #ssl_required :new, :create

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      @current_user = @user_session.user
      unless @current_user.active
        redirect_to root_path,
          :error => "Your account is currently inactive, please contact the administrator to activate it again."
      end
      successful_log_in_message = "Logged in successfully."
      if is_internal?
        redirect_to clients_path, :notice => successful_log_in_message
      else                # is a client
        session[:client_id] = @current_user.client.id if @current_user.client
        redirect_to root_path, :notice => successful_log_in_message
      end
    else
      flash.now[:error] = "Invalid login or password, or this account has been de-activated."
      render :action => 'new'
    end
  end

  def destroy
    current_user_session.destroy
    session[:client_id] = nil
    redirect_to root_url, :notice => "You have been logged out."

  end

  def reset
    session[:client_id] = nil if session[:client_id]
    session[:folder_id] = nil if session[:folder_id]
    redirect_to clients_path, :notice => "Current client unset.  Select a new client below."
  end
end
