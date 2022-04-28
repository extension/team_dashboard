class Response < ApplicationRecord
  belongs_to :submission

  def self.get_google_form_submission(email, survey, team, responses)
    # puts "responses from controller is: " + responses.inspect
    #create team
    team = Team.where(name: team).first_or_create

    #create survey
    survey = Survey.create(name: survey, team: team)

    #create submission
    submission = Submission.create(survey: survey)

    responses.each_with_index do |r, index|
      # puts r[1]
      Response.create(submission: submission,
                      question: r[0],
                      score: r[1],
                      question_number: index +1
                      )
    end

  end
end
