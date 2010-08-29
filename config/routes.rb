FileManager::Application::routes.draw do
  resources :user_sessions
  resources :documents
  resources :client_comments
  resources :document_statuses, :client_statuses, :base_folders

  resources :users do
    member do
      get :change_status
      get :set_current_staff_user
    end
  end
  resources :clients do
    member do
      get :set_current_client
    end
  end
  resources :folders do
    member do
      get :set_current_folder
      get :nest
    end
    collection do
      put :populate
    end
  end
  resources :documents do
    member do
      get :download_document
    end
  end
  resources :client_perms do
    collection do
      put :assign
    end
    member do
      get :set_current_staff_user_client
      get :delete_perms
    end
  end
  resources :folder_perms do
    collection do
      put :assign
    end
  end

  match '/login',           :to => 'user_sessions#new'
  match '/logout',          :to => 'user_sessions#destroy'
  match '/reset',           :to => 'user_sessions#reset'
  match '/change',          :to => 'users#edit_password'
  match '/update_password', :to => 'users#update_password'
  match '/help',            :to => 'users#toggle_help'
  match '/set_theme',       :to => 'users#set_theme'
  match 'admin',            :to => 'admin#instruct'
  match 'basic_info',       :to => 'clients#edit'
  match 'notes',            :to => 'client_comments#index'
  match 'display_privacy_statement', :to => 'welcome#display_privacy_statement'
  root                      :to => 'welcome#index'

end
