class ClientPerm < ActiveRecord::Base
  belongs_to :user
  belongs_to :client
  attr_accessible :user_id, :client_id
end
