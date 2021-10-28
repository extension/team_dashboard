json.extract! survey, :id, :name, :team_id, :created_at, :updated_at
json.url survey_url(survey, format: :json)
