class Book < ActiveRecord::Base
  attr_accessible :description, :title, :friendlytitle, :rights, :language, :gutenberg_id
  validates_uniqueness_of :gutenberg_id
  validates_uniqueness_of :google_books_id, :allow_nil => true

  belongs_to :author
  belongs_to :publisher
  has_many   :downloads

  before_save :truncate_values
  def truncate_values
    %w(title rights language friendlytitle).each do |m|
      self.send("#{ m }=", self.send(m).truncate(255)) unless self.send(m).nil?
    end
  end
end
