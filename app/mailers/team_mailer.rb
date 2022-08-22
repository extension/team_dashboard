class TeamMailer < ApplicationMailer
	#send email when a team leader submits a new team via google form
	def new_team_email
		@leader_name = params[:leader_name]
    @leader_email = params[:leader_email]
    @team_name = params[:team_name]
    @number_of_team_members = params[:number_of_team_members]
		mail(to: @leader_email, subject: "You Team has been created")
	end
end
