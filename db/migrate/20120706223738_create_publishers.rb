class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.string :url
      t.string :name

      t.timestamps
    end
  end
end
