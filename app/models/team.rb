class Team < ApplicationRecord
	has_many :surveys
	extend FriendlyId
	friendly_id :slug, use: :slugged
	before_validation :set_hashid, prepend: true, if: Proc.new{ |team| team.slug.nil? }

	private
		def set_hashid
			self.slug = (Digest::SHA256.base64digest self.name).gsub(/[\/=+$]/,"")[0,10]
		end
end
