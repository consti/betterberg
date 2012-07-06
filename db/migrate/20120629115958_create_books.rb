class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :friendlytitle
      t.string :rights
      t.text :description
      t.integer :author_id
      t.integer :publisher_id
      t.integer :gutenberg_id
      t.string  :google_books_id
      t.timestamps
    end
  end
end
