class AdminController < ApplicationController

  # current_section :admin

  def initialize
    @controller_name = self.class.to_s.sub(/Controller/,"").underscore
    @klass = @controller_name.singularize.camelize.constantize unless @controller_name == 'admin'
  end

  def instruct

    render :layout => 'admin'

  end

  def index
    user_role = current_user.role.name
    perms     = []
    @search_fields_array = ["name"]
    @current_objects = @klass.my_search(params[:search], params[:page], get_search_field, user_role, perms)
    # render :layout => 'admin'
    render 'admin/index'
  end

  def new
    @current_object = @klass.new
    render 'admin/new'
  end

  def show
    @current_object = @klass.find(params[:id])
    render 'admin/show'
  end

  def edit
    @current_object = @klass.find(params[:id])
    render 'admin/edit'
  end

  def create
    @current_object = @klass.new(params[@controller_name.singularize.to_sym])
    if @current_object.save
      flash[:notice] = "#{@controller_name.humanize} was successfully created."
      redirect_to :action => 'index'
    else
      render 'admin/new'
    end
  end

  def update
    @current_object = @klass.find(params[:id])
    if @current_object.update_attributes(params[@controller_name.singularize.to_sym])
      flash[:notice] = "#{@controller_name.humanize} was successfully updated."
      redirect_to :action => 'index'
    else
      render 'admin/edit'
    end
  end

  def destroy
    @current_object = @klass.find(params[:id])
    @current_object.destroy
    flash[:warning] = "Sucessfully destroyed #{@controller_name.humanize}."
    redirect_to :action => 'index'
  end

end
