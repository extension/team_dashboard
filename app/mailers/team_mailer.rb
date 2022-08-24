class TeamMailer < ApplicationMailer
	#send email when a team leader submits a new team via google form
	def new_team_email
    @leader_email = params[:email]
    @team_name = params[:team]
		mail(to: @leader_email, subject: "Your Team has been created")
	end
end
