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
      team = teams(:test_team)
      expect(team.name).to eql "test_team"
    end
  end

  describe "test 1st, 2nd, 3rd and final notification logic" do
    it "tests all teams" do
      survey = surveys(:survey_one)
      survey.created_at = survey.created_at + 60.days
      survey.save
      result = Team.get_next_survey_notification
      puts "result is: " + result.inspect
    end
  end

  describe "test indivigual method" do
    it "test intial_survey_notification" do
      team = teams(:test_team)
      result = Team.intial_survey_notification(team, 60)
      expect(result).to eq("send 60 day email")
      # puts "result is: " + result.inspect
    end
  end
end