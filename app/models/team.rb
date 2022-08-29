class Team < ApplicationRecord
	has_many :surveys
	validates :leader_name, :leader_email, :name, :number_of_team_members, presence: true
	validates :name, uniqueness: true

	extend FriendlyId
	friendly_id :slug, use: :slugged

	before_validation :set_hashid, prepend: true, if: Proc.new{ |team| team.slug.nil? }

	def self.get_google_form_team_submission(leader_name, leader_email, team_name, number_of_team_members)
  	team = Team.create(leader_name: leader_name,
  										 leader_email: leader_email,
  										 name: team_name,
  										 number_of_team_members: number_of_team_members)
  end

	def get_team_member_emails
		#team > survey > submission > user.email
		member_emails = []
		self.surveys.each do |survey|
			survey.submissions.each do |submission|
				member_emails << submission.user.email
			end
		end
		return member_emails
	end

	#this method used to send subsequent (2nd, 3rd, final) email notifications to group
	def send_next_survey_notification
		#loop through teams
		teams = Team.all
		teams.each do |team|
			first_baseline_submission = team.surveys.where(name: "Initial Baseline Survey").pluck(:created_at).min
			progress_in_days = (DateTime.now.to_date - progress_in_days = first_baseline_submission.to_date).to_i
			if submission_threshhold_met(team, progress_in_days)
				get_next_survey_notification(team, progress_in_days)
			end
		end
	end

	def get_next_survey_notification(team, progress_in_days)
		number_of_baseline_surveys = team.surveys.where(name: "Initial Baseline Survey").count
		number_of_second_surveys = team.surveys.where(name: "Second Survey").count
		number_of_third_surveys = team.surveys.where(name: "Thrid Survey").count
		number_of_final_surveys = team.surveys.where(name: "Final Survey").count

		if progress_in_days < 91 && (number_of_baseline_surveys >= team.number_of_team_members)
			
		elsif progress_in_days.between?(90, 180) && (number_of_second_surveys >= (team.number_of_team_members * .8))

		elsif progress_in_days.between?(181, 270) && (number_of_third_surveys >= (team.number_of_team_members * .8))

		elsif progress_in_day.between(271, 360) && (number_of_final_surveys >= (team.number_of_team_members * .8))

		else

		end
			
	end

	private
		def set_hashid
			self.slug = (Digest::SHA256.base64digest self.name).gsub(/[\/=+$]/,"")[0,10]
		end
end
