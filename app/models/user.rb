class User < ApplicationRecord
  has_many :submissions
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    return nil unless email =~ /@extension.org\z/
    create_with(uid: uid, full_name: full_name, avatar_url: avatar_url).find_or_create_by!(email: email)
  end
end
