class BaseFoldersController < AdminController

  def index
    user_role = current_user.role.name
    perms = []
    @search_fields_array = ["name"]
    @base_folders = BaseFolder.my_search(params[:search], params[:page], get_search_field, user_role, perms)
    render :layout => 'admin'
  end

  def show
    @base_folder = BaseFolder.find(params[:id])  
    render :layout => 'admin'
  end

  def new
    @base_folder = BaseFolder.new
    render :layout => 'admin'
  end

  def create
    @base_folder = BaseFolder.new(params[:base_folder])
    if @base_folder.save
      flash[:notice] = "Base folder was successfully created."
      redirect_to :base_folder
    else
      render :action => 'new'
    end
  end

  def edit
    @base_folder = BaseFolder.find(params[:id])
    render :layout => 'admin'
  end

  def update
    @base_folder = BaseFolder.find(params[:id])
    if @base_folder.update_attributes(params[:base_folder])
      flash[:notice] = "Base folder was successfully updated."
      redirect_to :action => 'index'
    else
      render :action => "edit"
    end
  end

  def destroy
    @base_folder = BaseFolder.find(params[:id])
    @base_folder.destroy
    flash[:warning] = "Base folder sucessfully destroyed."
    redirect_to :action => 'index'
  end

end
