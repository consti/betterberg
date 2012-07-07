class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.date   :birthdate
      t.date   :deathdate
      t.string :alias
      t.text :webpage
      t.integer :gutenberg_id

      t.timestamps
    end
  end
end
