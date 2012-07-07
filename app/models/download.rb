class Download < ActiveRecord::Base
  attr_accessible :filetype, :filesize, :last_modified, :url

  belongs_to :book
end