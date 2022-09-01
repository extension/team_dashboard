require "rails_helper"

RSpec.describe Team do
  fixtures :all

	describe "team name" do
		team = Team.new(name: "my team")
    it "creates a new team" do
    	expect(team.name).to eq "my team"
    end
  end

  describe "next survey notifications" do
    it "send notification for intial_survey_notification" do
      team = teams(:team_one)
      expect(team.name).to eql "team_one"
    end
  end

  describe "test 1st, 2nd, 3rd and final notification logic" do
    it "tests all teams" do
      survey = surveys(:survey_one)
      survey.created_at = survey.created_at + 60.days
      survey.save
      result = Team.get_next_survey_notification
      #also check that survey_status[:initial_survey_complete] = true
      # puts "result is: " + result.inspect
    end
  end

  describe "test mailers" do
    it "tests initial_survey_notification two month nag message to team lead" do
      team = teams(:team_one)
      mail = Team.initial_survey_notification(team, 60)
      expect(mail.subject).to eq("Your Teams Progress")
    end

    it "tests initial_survey_notification and all members have submitted surveys" do
      #TODO this test cold be improved so it handles multiple emails being sent to team members
      #not crazy about this test, but good 'nuf for now'
      team = teams(:team_two)
      mail = Team.initial_survey_notification(team, 60)
      #this tests that the get_team_member_emails method returns emails as it should
      expect(mail).to eq(["bustas2@wintas.com", "bustas3@wintas.com", "bustas4@wintas.com", "bustas5@wintas.com"])
      #directly test the mailer
      mailer = TeamMailer.with(email: "bustas2@wintas.com", team: team.name, slug: team.slug).initial_survey_threshold_met.deliver_now
      expect(mailer.subject).to eq("Team Health Dashboard")
    end
  end
end