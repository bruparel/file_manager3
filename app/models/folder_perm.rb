class FolderPerm < ActiveRecord::Base
  belongs_to :user
  belongs_to :client
  belongs_to :folder
  attr_accessible :user_id, :client_id, :folder_id
end
