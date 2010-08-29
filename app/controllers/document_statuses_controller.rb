class DocumentStatusesController < AdminController

  def index
    user_role = current_user.role.name
    perms = []
    @search_fields_array = ["name"]
    @document_statuses = DocumentStatus.my_search(params[:search], params[:page], get_search_field, user_role, perms)
    render :layout => 'admin'
  end

  def show
    @document_status = DocumentStatus.find(params[:id])  
    render :layout => 'admin'
  end

  def new
    @document_status = DocumentStatus.new
    render :layout => 'admin'
  end

  def create
    @document_status = Documentstatus.new(params[:document_status])
    if @document_status.save
      flash[:notice] = "Document status was successfully created."
      redirect_to :document_statuses
    else
      render :action => 'new'
    end
  end

  def edit
    @document_status = DocumentStatus.find(params[:id])
    render :layout => 'admin'
  end

  def update
    @document_status = DocumentStatus.find(params[:id])
    if @document_status.update_attributes(params[:document_status])
      flash[:notice] = "Document status was successfully updated."
      redirect_to :action => 'index'
    else
      render :action => "edit"
    end
  end

  def destroy
    @document_status = DocumentStatus.find(params[:id])
    @document_status.destroy
    flash[:warning] = "Document status sucessfully destroyed."
    redirect_to :action => 'index'
  end

end
