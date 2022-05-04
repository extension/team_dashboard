class Team < ApplicationRecord
	has_many :surveys

	extend FriendlyId
	friendly_id :slug, use: :slugged

	before_validation :set_hashid, prepend: true, if: Proc.new{ |team| team.slug.nil? }

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

	private
		def set_hashid
			self.slug = (Digest::SHA256.base64digest self.name).gsub(/[\/=+$]/,"")[0,10]
		end
end
