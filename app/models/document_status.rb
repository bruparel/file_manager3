class DocumentStatus < ActiveRecord::Base
  has_many :documents
  attr_accessible :name
  validates_presence_of :name, :message => "^You must specify a document status name."
  validates_uniqueness_of :name
end
