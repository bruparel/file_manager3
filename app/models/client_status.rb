class ClientStatus < ActiveRecord::Base
  has_many :clients
  attr_accessible :name
  validates_presence_of :name, :message => "^You must specify a client status name."
end
