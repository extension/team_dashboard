# Preview all emails at http://localhost:3000/rails/mailers/team
class TeamPreview < ActionMailer::Preview
	def new_team_email
		team = Team.last
    @leader_email = team.leader_email
		TeamMailer.with(to: @leader_email, subject: "Your Team has been created").new_team_email
	end

	def initial_survey_nag_email
		team = Team.last
		@leader_name = team.leader_name
		@total_team_members = team.number_of_team_members
		TeamMailer.with(total_team_members: @total_team_members, survey_count: 3, leader_name: @leader_name, team: @team, subject: "Your Teams Progress").initial_survey_nag_email
	end

	def initial_survey_threshold_met
		team = Team.last
		@team_name = team.name
		@team_slug = team.slug
		TeamMailer.with(team_name: @team_name, team_slug: @team_slug, to: @email, subject: "Team Health Dashboard").initial_survey_threshold_met
	end

	def second_survey_email
		team = Team.last
		@team_name = team.name
		TeamMailer.with(team_name: @team_name, to: @leader_email, subject: "Your Next Team Health Survey").second_survey_email
	end

	def second_survey_nag_email
		team = Team.last
		@leader_name = team.leader_name
		@total_team_members = team.number_of_team_members
		TeamMailer.with(total_team_members: @total_team_members, survey_count: 3, leader_name: @leader_name, team: @team, subject: "Your Teams Progress").second_survey_nag_email
	end

	def second_survey_threshold_met
		team = Team.last
		@team_name = team.name
		@team_slug = team.slug
		TeamMailer.with(team_name: @team_name, team_slug: @team_slug, to: @email, subject: "Team Health Dashboard").second_survey_threshold_met
	end

	def third_survey_email
		team = Team.last
		@team_name = team.name
		TeamMailer.with(team_name: @team_name, to: @leader_email, subject: "Your Next Team Health Survey").third_survey_email
	end

	def third_survey_nag_email
	team = Team.last
		@leader_name = team.leader_name
		@total_team_members = team.number_of_team_members
		TeamMailer.with(total_team_members: @total_team_members, survey_count: 3, leader_name: @leader_name, team: @team, subject: "Your Teams Progress").third_survey_nag_email
	end

	def third_survey_threshold_met
		team = Team.last
		@team_name = team.name
		@team_slug = team.slug
		TeamMailer.with(team_name: @team_name, team_slug: @team_slug, to: @email, subject: "Team Health Dashboard").third_survey_threshold_met
	end

	def final_survey_email
		team = Team.last
		@team_name = team.name
		TeamMailer.with(team: @team_name, subject: "Your Final Team Health Survey").final_survey_email
	end

	def final_survey_nag_email
		team = Team.last
		@leader_name = team.leader_name
		@total_team_members = team.number_of_team_members
		TeamMailer.with(total_team_members: @total_team_members, survey_count: 3, leader_name: @leader_name, team: @team, subject: "Your Teams Progress").final_survey_nag_email
	end

	def final_survey_threshold_met
		team = Team.last
		@team_name = team.name
		@team_slug = team.slug
		TeamMailer.with(team_name: @team_name, team_slug: @team_slug, to: @email, subject: "Team Health Dashboard").final_survey_threshold_met
	end

	def final_email
		team = Team.last
		@team_slug = team.slug
		TeamMailer.with(team_slug: @team_slug, to: @email, subject: "Team Health Dashboard").final_email
	end

end
