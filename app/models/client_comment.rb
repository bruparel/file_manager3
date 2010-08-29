class ClientComment < ActiveRecord::Base
  belongs_to :client
  belongs_to :user
  attr_accessible :content, :client_id, :user_id
  validates_presence_of :content, :message => "^Empty comment/notes cannot be saved."  

  # define_index do
  #   indexes content
  #   has client_id, created_at
  #   set_property :delta => true
  # end

end
