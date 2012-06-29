class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.string :url
      t.string :filetype
      t.integer :book_id
      t.timestamps
    end
  end
end
