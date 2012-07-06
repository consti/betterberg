class Author < ActiveRecord::Base
  attr_accessible :about, :name
  
  has_many :books
  has_many :publisher, :through => :books
end
