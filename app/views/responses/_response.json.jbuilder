json.extract! response, :id, :question, :score, :time_entered, :question_number, :submission_id, :created_at, :updated_at
json.url response_url(response, format: :json)
