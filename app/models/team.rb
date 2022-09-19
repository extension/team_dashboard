class Team < ApplicationRecord
	has_many :surveys
	validates :leader_name, :leader_email, :name, :number_of_team_members, presence: true
	validates :name, uniqueness: true
	serialize :survey_status, Hash

	extend FriendlyId
	friendly_id :slug, use: :slugged

	# before_validation :set_hashid, prepend: true, if: Proc.new{ |team| team.slug.nil? }

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
	def self.get_next_survey_notification
		teams = Team.all
		teams.each do |team|
			first_baseline_submission = team.surveys.where(name: "Initial Baseline Survey").pluck(:created_at).min
			progress_in_days = (first_baseline_submission.to_date - DateTime.now.to_date).to_i
			if progress_in_days < 91 && team.survey_status[:initial_survey_complete].nil?
				initial_survey_notification(team, progress_in_days)
			elsif progress_in_days.between?(90, 180) && team.survey_status[:second_survey_complete].nil?
				second_survey_notification(team, progress_in_days)
			elsif progress_in_days.between?(181, 270) && team.survey_status[:third_survey_complete].nil?
				third_survey_notification(team. progress_in_days)
			elsif progress_in_days.between?(271, 360) && team.survey_status[:final_survey_complete].nil?
				final_survey_notification(team, progress_in_days)
			end
		end
	end

	#the notifications below are based on the a predetermined threshold of surveys being submitted
	#before an email is sent to the team

	def self.initial_survey_notification(team, progress_in_days)
		survey_count = team.surveys.where(name: "Initial Baseline Survey").count
		if progress_in_days == 60 && survey_count < team.number_of_team_members
			#two months into this phase and all team members have not submitted survey, send a nag message to team lead
			TeamMailer.with(leader_name: team.leader_name, email: team.leader_email, team: team.name).initial_survey_nag_email.deliver_now
		elsif survey_count >= team.number_of_team_members
			#send survey threshold met notification
			team.get_team_member_emails.each do |email|
				TeamMailer.with(email: email, team: team.name, slug: team.slug).initial_survey_threshold_met.deliver_now
			end
			team.survey_status[:initial_survey_complete] = true
		end
	end

	def self.second_survey_notification(team, progress_in_days)
		survey_count = team.surveys.where(name: "Second Survey").count
		if progress_in_days == 90  && survey_count < team.number_of_team_members
			#two months into this phase and all team members have not submitted survey, send a nag message to team lead
			TeamMailer.with(leader_name: team.leader_name, email: team.leader_email, team: team.name).second_survey_nag_email.deliver_now
		elsif survey_count >= team.number_of_team_members * 0.8
			#send survey threshold met notification
			team.survey_status[:second_survey_complete] = true
		elsif progress_in_days == 150
			#two months into this phase, send a nag message to team lead
		else
			#this means the previous survey threshold was never met; send reminder to team lead
		end
	end

	def self.third_survey_notification(team, progress_in_days)
		survey_count = team.surveys.where(name: "Third Survey").count
		if progress_in_days == 180  && survey_count < team.number_of_team_members
			#two months into this phase and all team members have not submitted survey, send a nag message to team lead
			TeamMailer.with(leader_name: team.leader_name, email: team.leader_email, team: team.name).third_survey_nag_email.deliver_now
		elsif survey_count >= team.number_of_team_members * 0.8
			#send survey threshold met notification
			team.survey_status[:third_survey_complete] = true
		elsif progress_in_days == 241
			#two months into this phase, send a nag message to team lead
		else
			#this means the previous survey threshold was never met; send reminder to team lead
		end
	end

	def self.final_survey_notification(team, progress_in_days)
		survey_count = team.surveys.where(name: "Final Survey").count
		if progress_in_days == 271 && survey_count < team.number_of_team_members
			#two months into this phase and all team members have not submitted survey, send a nag message to team lead
			TeamMailer.with(leader_name: team.leader_name, email: team.leader_email, team: team.name).final_survey_nag_email.deliver_now
		elsif survey_count >= team.number_of_team_members * 0.8
			#send survey threshold met notification
			team.survey_status[:final_survey_complete] = true
		elsif progress_in_days == 331
			#two months into this phase, send a nag message to team lead
		else
			#this means the previous survey threshold was never met; send final email to team lead
		end
	end

	private
		def set_hashid
			self.slug = (Digest::SHA256.base64digest self.name).gsub(/[\/=+$]/,"")[0,10]
		end
end
