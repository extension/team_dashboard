# Preview all emails at http://localhost:3000/rails/mailers/responses_mailer
class ResponsesMailerPreview < ActionMailer::Preview
	def new_response_email
		response = Response.new(email: "marklocklear@extension.org",
														survey: "Initial Baseline",
														team: "My Team")

		ResponsesMailer.with(response).new_response_email
	end
end
