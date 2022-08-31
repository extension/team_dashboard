class AddSurveyStatusToTeam < ActiveRecord::Migration[7.0]
  def change
    add_column :teams, :survey_status, :text
  end
end
