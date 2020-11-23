class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.text :description
      t.string :title
      t.float :longitude
      t.float :latitude
      t.integer :progress

      t.timestamps
    end
  end
end
