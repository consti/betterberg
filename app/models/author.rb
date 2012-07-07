class Author < ActiveRecord::Base
  attr_accessible :name, :birthdate, :deathdate, :alias, :webpage, :gutenberg_id
  
  has_many :books
  has_many :publisher, :through => :books
end
