class CreateResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :responses do |t|
      t.text :question
      t.integer :score
      t.datetime :time_entered
      t.string :question_number
      t.references :submission, null: false, foreign_key: true

      t.timestamps
    end
  end
end
