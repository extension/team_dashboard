desc "send notifications"
task send_notifications: :environment do
	Team.get_next_survey_notification
end