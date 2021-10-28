class CreateSubmissions < ActiveRecord::Migration[6.1]
  def change
    create_table :submissions do |t|
      t.string :submitted_date
      t.references :survey, null: false, foreign_key: true

      t.timestamps
    end
  end
end
