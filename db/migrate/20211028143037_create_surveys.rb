class CreateSurveys < ActiveRecord::Migration[6.1]
  def change
    create_table :surveys do |t|
      t.string :name
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
