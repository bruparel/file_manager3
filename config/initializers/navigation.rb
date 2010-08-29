RPH::Navigation::Builder.config do |navigation|

  navigation.define :admin do |menu|
    menu.item :clients
    menu.item :folders
    menu.item :documents
    #menu.item :client_comments, :text => "Notes"
    menu.item :users
    menu.item :client_perms
    menu.item :folder_perms
    menu.item :admin
  end

  navigation.define :leader_or_staff do |menu|
    menu.item :clients
    menu.item :folders
    menu.item :documents
  end
  
  navigation.define :welcome do |menu|
    menu.item :welcome, :path => :root_path
  end

  navigation.define :second_level_admin do |menu|
    menu.item :client_statuses
    menu.item :document_statuses
    menu.item :base_folders
  end
  
end
