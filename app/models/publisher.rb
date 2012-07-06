class Publisher < ActiveRecord::Base
  attr_accessible :name, :url

  has_many :books
  has_many :authors, :through => :books
end
