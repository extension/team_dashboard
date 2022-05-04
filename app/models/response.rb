class Response < ApplicationRecord
  belongs_to :submission
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      count = 1

      team = Team.where(name: row[3]).first_or_create

      (0..14).each do |i|
        #create survey
        survey = Survey.where(team: team, name: row[2]).first_or_create
        #create submission
        submission = Submission.where(survey: survey,
                                      submitted_date: row[0]).first_or_create
        Response.where(submission: submission,
                       question: row.headers[i+4],
                       score: row[i+4],
                       time_entered: DateTime.strptime(row[0], '%m/%d/%Y %H:%M:%S'),
                       question_number: count
                      ).first_or_create
        count += 1
      end
    end
  end

  def self.get_google_form_submission(email, survey, team, responses)
    # puts "responses from controller is: " + responses.inspect
    #create team
    team = Team.where(name: team).first_or_create

    #create survey
    survey = Survey.create(name: survey, team: team)

    #create user
    user = User.create(email: email)

    #create submission
    submission = Submission.create(survey: survey, user: user)

    responses.each_with_index do |r, index|
      Response.create(submission: submission,
                      question: r[0],
                      score: r[1],
                      question_number: index +1
                      )
    end

  end
end
