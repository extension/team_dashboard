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
      #directly test the mailer
      team = teams(:team_one)
      mailer = TeamMailer.with(email: "bustas2@wintas.com", team: team.name, slug: team.slug).initial_survey_threshold_met.deliver_now
      expect(mailer.subject).to eq("Team Health Dashboard")
    end

    it "should set initial survey status to complete" do
      team = teams(:team_two)
      Team.initial_survey_notification(team, 60)
      expect(team.survey_status[:initial_survey_complete]).to eq(true)
    end
  end
end