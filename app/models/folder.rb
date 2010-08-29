class Folder < ActiveRecord::Base

  acts_as_tree :order => "name"

  scope :sibling_folders, lambda { |parent_id| {:conditions => {:parent_id => parent_id} } }

  has_many :documents
  has_many :folder_perms
  belongs_to :client

  attr_accessible :name, :eclient_flag, :client_id, :parent_id
  validates_presence_of :name, :message => "^You must specify a folder name."
  validates_uniqueness_of :name, :scope => :client_id
 
  def owner
    self.client.client_name
  end
  
end
