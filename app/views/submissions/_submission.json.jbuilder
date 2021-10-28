json.extract! submission, :id, :submitted_date, :survey_id, :created_at, :updated_at
json.url submission_url(submission, format: :json)
