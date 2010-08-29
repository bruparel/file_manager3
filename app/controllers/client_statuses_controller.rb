class ClientStatusesController < ApplicationController

  def index
    user_role = current_user.role.name
    perms = []
    @search_fields_array = ["name"]
    @client_statuses = ClientStatus.my_search(params[:search], params[:page], get_search_field, user_role, perms)
    render :layout => 'admin'
  end

  def show
    @client_status = ClientStatus.find(params[:id])  
    render :layout => 'admin'
  end

  def new
    @client_status = ClientStatus.new
    render :layout => 'admin'
  end

  def create
    @client_status = ClientStatus.new(params[:client_status])
    if @client_status.save
      flash[:notice] = "Client status was successfully created."
      redirect_to :client_statuses
    else
      render :action => 'new'
    end
  end

  def edit
    @client_status = ClientStatus.find(params[:id])
    render :layout => 'admin'
  end

  def update
    @client_status = ClientStatus.find(params[:id])
    if @client_status.update_attributes(params[:client_status])
      flash[:notice] = "Client status was successfully updated."
      redirect_to :action => 'index'
    else
      render :action => "edit"
    end
  end

  def destroy
    @client_status = ClientStatus.find(params[:id])
    @client_status.destroy
    flash[:warning] = "Client status sucessfully destroyed."
    redirect_to :action => 'index'
  end

end
