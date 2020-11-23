class CreateCheckpoints < ActiveRecord::Migration[6.0]
  def change
    create_table :checkpoints do |t|
      t.references :user, null: false, foreign_key: true
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
