class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.references :project, null: false, foreign_key: true
      t.string :first_answer
      t.string :second_answer

      t.timestamps
    end
  end
end
