module StaffUserIdentification

  def self.included(controller)
    controller.send :helper_method, :current_staff_user, :current_staff_user_selection_required,
                    :current_staff_user_client, :current_staff_user_and_client_selection_required
  end

  def current_staff_user
    @current_staff_user ||= User.find(session[:staff_user_id]) if session[:staff_user_id]
  end

  def current_staff_user_client
    @current_staff_user_client ||= Client.find(session[:staff_user_client_id]) if session[:staff_user_client_id]
  end

  def current_staff_user_selection_required
    unless current_staff_user
      flash[:error] = "You must first select a staff user before accessing this page."
      redirect_to users_path
    end
  end

  def current_staff_user_and_client_selection_required
    current_staff_user_selection_required
    unless current_staff_user_client
      flash[:error] = "You must first select a client for this staff user before accessing this page."
      redirect_to :controller => 'clients', :action => 'list_perms'
    end
  end

end