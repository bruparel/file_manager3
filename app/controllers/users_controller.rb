class UsersController < ApplicationController

  before_filter :login_required
  #ssl_required  :new, :create, :edit, :update, :edit_password, :update_password

  def index
    @role_array = Role.all.collect {|r| [r.name,r.id.to_s]}
    @search_fields_array = ["email","username"]
    #@users = User.search(params[:search], params[:page], get_search_field)
    if (params[:which_action].nil?) || (params[:which_action] == "Search")
      @users = User.my_search(params[:search], params[:page], get_search_field,"not_staff",[])
    else                # params[:which_action] == "Filter"
      @users = User.filter_by_status(params[:filter_by], params[:page], "role_id","not_staff",[])
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "User account created and is ready for use."
      redirect_to users_path
    else
      render :action => 'new'
    end
  end

  def edit
    # only admins are going to access this under current assumptions
    @user = User.find(params[:id])
  end

  def edit_password
    @user = @current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User data was successfully updated.'
      redirect_to(is_internal? ? users_path : edit_user_path(@user))
    else
      render :action => "edit"
    end
  end

  def update_password
    @user = @current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Password successfully updated."
      redirect_to(is_internal? ? clients_path : edit_client_path(current_user.client))
    else
      flash.now[:error] = current_user.errors[:base] || "There was a problem updating your password."
      render :action => :edit
    end
  end

  def set_current_staff_user
    @current_staff_user = User.find(params[:id])
    session[:staff_user_id] = @current_staff_user.id
    flash[:notice] = "Current staff user set to #{current_staff_user.display_name}. Assign client permissions."
    redirect_to :controller => 'client_perms', :action => 'index'
  end

  def change_status
    @user = User.find(params[:id])
    @user.update_attribute(:active, (@user.active ? false : true))
    flash[:warning] = "Set user status to " + (@user.active ? "active" : "in-active") + " for " + @user.username
    redirect_to users_path
  end

  def set_theme
    current_user.update_attribute(:theme, params[:id])
    flash[:notice] = "Set the new theme to #{params[:id]}"
    redirect_to :back
  end

  def toggle_help
    current_user.update_attribute(:help_on, !current_user.help_on)
    flash[:notice] = "System wide help has been turned " + (current_user.help_on ? "on" : "off")
    redirect_to :back
  end

end
