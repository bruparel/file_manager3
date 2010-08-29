module ClientsHelper
  def folder_perms_exist?(userid,clientid)
    FolderPerm.find(:first,:conditions => ["user_id = ? and client_id = ?",userid,clientid])
  end
end
