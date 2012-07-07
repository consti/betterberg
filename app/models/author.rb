class Author < ActiveRecord::Base
  attr_accessible :name, :birthdate, :deathdate, :alias, :webpage, :gutenberg_id
  
  has_many :books
  has_many :publisher, :through => :books

  before_save :truncate_values
  def truncate_values
    %w(name alias).each do |m|
      self.send("#{ m }=", self.send(m).truncate(255)) unless self.send(m).nil?
    end
  end

end
