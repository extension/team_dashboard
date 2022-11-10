class TeamMailer < ApplicationMailer
	#send email when a team leader submits a new team via google form
	def new_team_email
    @leader_email = params[:email]
    @team_name = params[:team_name]
		mail(to: @leader_email, subject: "Your Team has been created")
	end

	def initial_survey_nag_email
		@leader_name = params[:leader_name]
		@team_name = params[:team_name]
		@survey_count = params[:survey_count]
		@leader_email = params[:email]
		@total_team_members = params[:total_team_members]
		mail(to: @leader_email, subject: "Your Teams Progress")
	end

	def initial_survey_threshold_met
		@team_name = params[:team_name]
		@team_slug = params[:team_slug]
		@email = params[:email]
		mail(to: @email, subject: "Team Health Dashboard")
	end

	def second_survey_email
    @leader_email = params[:email]
    @team_name = params[:team_name]
		mail(to: @leader_email, subject: "Your Next Team Health Survey")
	end

	def second_survey_nag_email
   	@leader_name = params[:leader_name]
		@team_name = params[:team_name]
		@survey_count = params[:survey_count]
		@leader_email = params[:email]
		@total_team_members = params[:total_team_members]
		mail(to: @leader_email, subject: "Your Teams Progress")
	end

	def second_survey_threshold_met
		@team_name = params[:team_name]
		@team_slug = params[:team_slug]
		@email = params[:email]
		mail(to: @email, subject: "Team Health Dashboard")
	end

	def third_survey_email
    @leader_email = params[:email]
    @team_name = params[:team_name]
		mail(to: @leader_email, subject: "Your Next Team Health Survey")
	end

	def third_survey_nag_email
   	@leader_name = params[:leader_name]
		@team_name = params[:team_name]
		@survey_count = params[:survey_count]
		@leader_email = params[:email]
		@total_team_members = params[:total_team_members]
		mail(to: @leader_email, subject: "Your Teams Progress")
	end

	def third_survey_threshold_met
		@team_name = params[:team_name]
		@team_slug = params[:team_slug]
		@email = params[:email]
		mail(to: @email, subject: "Team Health Dashboard")
	end

	def final_survey_email
    @leader_name = params[:leader_name]
    @leader_email = params[:email]
    @team_name = params[:team]
		mail(to: @leader_email, subject: "Your Final Team Health Survey")
	end

	def final_survey_nag_email
		@leader_name = params[:leader_name]
		@survey_count = params[:survey_count]
		@leader_email = params[:email]
		@total_team_members = params[:total_team_members]
		mail(to: @leader_email, subject: "Your Teams Progress")
	end

	def final_survey_threshold_met
		@team_name = params[:team_name]
		@team_slug = params[:team_slug]
		@email = params[:email]
		mail(to: @email, subject: "Team Health Dashboard")
	end

	def final_email
		@team_slug = params[:team_slug]
		@email = params[:email]
		mail(to: @email, subject: "Team Health Dashboard")
	end
end
