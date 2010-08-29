class Role < ActiveRecord::Base
  has_many :users
  validates_presence_of     :name, :display_name
  validates_uniqueness_of   :name, :display_name
end