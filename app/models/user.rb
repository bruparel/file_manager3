require 'digest/sha1'
class User < ActiveRecord::Base

  acts_as_authentic

  has_many :comments, :as => :commentable, :order => "created_at DESC"
  has_many :client_perms
  has_many :folder_perms
  has_many :client_comments
  belongs_to :role
  belongs_to :client        # this is for an external client which can have many users

  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :display_name, :email, :password, :password_confirmation,
                  :comment, :active, :role_id, :client_id
  attr_reader :password

  validates_presence_of :display_name, :role_id

  validate                  :correct_client_assignment

  private

  def correct_client_assignment
    role = Role.find_by_name('eclient')
    if client_id.blank? && role_id == role.id
      errors.add :client_id, "must assign an external client to this user"
    elsif !client_id.blank? && role_id != role.id
      errors.add :client_id, "cannot assign an internal user to a client"
    end
  end
  
end
