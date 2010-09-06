FileManager::Application::routes.draw do
  resources :user_sessions
  resources :documents
  resources :client_comments
  resources :document_statuses, :client_statuses, :base_folders

  resources :users do
    get :change_status,          :on => :member
    get :set_current_staff_user, :on => :member
  end

  resources :clients do
    get :set_current_client, :on => :member
  end

  resources :folders do
    get :set_current_folder, :on => :member
    get :nest,               :on => :member
    put :populate,           :on => :collection
  end

  resources :documents do
    get :download_document, :on => :member
  end

  resources :client_perms do
    put :assign,                        :on => :collection
    get :set_current_staff_user_client, :on => :member
    get :delete_perms,                  :on => :member
  end

  resources :folder_perms do
    put :assign, :on => :collection
  end

  match '/login',                   :to => 'user_sessions#new'
  match '/logout',                   :to => 'user_sessions#destroy'
  match '/reset',                    :to => 'user_sessions#reset'
  match '/change',                   :to => 'users#edit_password'
  match '/update_password',          :to => 'users#update_password'
  match '/help',                     :to => 'users#toggle_help'
  match '/set_theme',                :to => 'users#set_theme'
  match 'admin',                     :to => 'admin#instruct'
  match 'basic_info',                :to => 'clients#edit'
  match 'notes',                     :to => 'client_comments#index'
  match 'display_privacy_statement', :to => 'welcome#display_privacy_statement'
  root                               :to => 'welcome#index'

end
