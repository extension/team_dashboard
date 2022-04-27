class Response < ApplicationRecord
  belongs_to :submission

  # require 'csv'

  # def self.import(file)
  #   CSV.foreach(file.path, headers: true) do |row|
  #     count = 1

  #     team = Team.where(name: row[3]).first_or_create

  #     (0..14).each do |i|
  #       #create survey
  #       survey = Survey.where(team: team, name: row[2]).first_or_create
  #       #create submission
  #       submission = Submission.where(survey: survey,
  #                                     submitted_date: row[0]).first_or_create
  #       Response.where(submission: submission,
  #                      question: row.headers[i+4],
  #                      score: row[i+4],
  #                      time_entered: DateTime.strptime(row[0], '%m/%d/%Y %H:%M:%S'),
  #                      question_number: count
  #                     ).first_or_create
  #       count += 1
  #     end
  #   end
  # end

  def self.get_google_form_submission(email, survey, team, responses)
    puts "responses from controller is: " + responses.inspect
  end
end
