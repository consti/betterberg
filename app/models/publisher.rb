class Publisher < ActiveRecord::Base
  attr_accessible :name, :url

  has_many :books
  has_many :authors, :through => :books

  before_save :truncate_values
  def truncate_values
    %w(name).each do |m|
      self.send("#{ m }=", self.send(m).truncate(255)) unless self.send(m).nil?
    end
  end

end
