class ResponsesMailer < ApplicationMailer
	#send email when a user submits a google form survey
	def new_response_email
		@email = params[:email]
		@survey_name = params[:survey]
		@team_name = params[:team]
		mail(to: @email, subject: "Thank you for submitting your response")
	end
end
