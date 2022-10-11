# Preview all emails at http://localhost:3000/rails/mailers/team
class TeamPreview < ActionMailer::Preview
	def new_team_email
    @leader_email = params[:email]
		TeamMailer.with(to: @leader_email, subject: "Your Team has been created").new_team_email
	end

	def initial_survey_nag_email
		TeamMailer.with(to: @leader_email, subject: "Your Team has been created").initial_survey_nag_email
	end

	def initial_survey_threshold_met
		TeamMailer.with(to: @email, subject: "Team Health Dashboard").initial_survey_threshold_met
	end

	def second_survey_email
		TeamMailer.with(to: @leader_email, subject: "Your Next Team Health Survey").second_survey_email
	end

	def second_survey_nag_email
		TeamMailer.with(to: @leader_email, subject: "Your Teams Progress").second_survey_nag_email
	end

	def second_survey_threshold_met
		TeamMailer.with(to: @email, subject: "Team Health Dashboard").second_survey_threshold_met
	end

	def third_survey_email
		TeamMailer.with(to: @leader_email, subject: "Your Next Team Health Survey").third_survey_email
	end

	def third_survey_nag_email
		TeamMailer.with(to: @leader_email, subject: "Your Teams Progress").third_survey_nag_email
	end

	def third_survey_threshold_met
		TeamMailer.with(to: @email, subject: "Team Health Dashboard").third_survey_threshold_met
	end

	def final_survey_email
		TeamMailer.with(to: @leader_email, subject: "Your Final Team Health Survey").final_survey_email
	end

	def final_survey_nag_email
		@leader_name = Team.last.leader_name
		# @team_name = "Team Candler"
		team = Team.last
		@team_name = team.name
		@survey_count = team.surveys.count

		TeamMailer.with(team: @team_name, leader_name: @leader_name, subject: "Your Teams Progress").final_survey_nag_email
	end

	def final_survey_threshold_met
		TeamMailer.with(to: @email, subject: "Team Health Dashboard").final_survey_threshold_met
	end

	def final_email
		TeamMailer.with(to: @email, subject: "Team Health Dashboard").final_email
	end

end
