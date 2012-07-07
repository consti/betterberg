class Book < ActiveRecord::Base
  attr_accessible :description, :title, :rights, :language, :gutenberg_id
  validates_uniqueness_of :gutenberg_id
  validates_uniqueness_of :google_books_id, :allow_nil => true

  belongs_to :author
  belongs_to :publisher
  has_many   :downloads
end
