class Client < ActiveRecord::Base

  belongs_to :client_status
  has_many   :folders
  has_many   :client_comments
  has_many   :users
  has_many   :client_perms
  has_many   :folder_perms

  attr_accessible :client_name, :contact_name, :address1, :address2, :city, :state, :zip,
    :phone, :mobile, :fax, :client_status_id, :user_id, :comment

  validates_presence_of :client_name, :contact_name, :address1, :city, :state, :zip, :phone
  validates_uniqueness_of :client_name

end
