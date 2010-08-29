class BaseFolder < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name, :message => "^You must specify a base folder name."
end
