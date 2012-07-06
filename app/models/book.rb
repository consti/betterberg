class Book < ActiveRecord::Base
  attr_accessible :description, :title
  validates_uniqueness_of :gutenberg_id
  validates_uniqueness_of :google_books_id, :allow_nil => true

  belongs_to :author
  has_one    :publisher
end
