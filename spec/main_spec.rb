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

  describe "test initial_survey_notification" do
    it "should set initial survey status to complete" do
      team = teams(:team_two)
      Team.initial_survey_notification(team, 60)
      expect(team.survey_status[:initial_survey_complete]).to eq(true)
    end

    it "tests initial_survey_notification two month nag message to team lead" do
      team = teams(:team_one)
      mail = Team.initial_survey_notification(team, 60)
      expect(mail.body).to include("At this time only")
    end

    it "tests initial_survey_notification where survey threshold is met" do
      team = teams(:team_one)

      #build 10 surveys since team_one has 10 members
      build_surveys(team, "Initial Baseline Survey", 10)

      #TODO would really like to be testing the mailer here
      Team.initial_survey_notification(team, 60)
      expect(team.survey_status[:initial_survey_complete]).to eq true
    end
  end

  describe "test second_survey_notification" do
    it "tests second_survey_notification two month nag message to team lead" do
      team = teams(:team_one)
      mail = Team.second_survey_notification(team, 90)
      expect(mail.body).to include("At this time only")
    end

    it "tests second_survey_notification where survey threshold is not met" do
      team = teams(:team_one)

      #build 10 surveys since team_one has 10 members
      build_surveys(team, "Second Survey", 7)

      #TODO would really like to be testing the mailer here
      Team.second_survey_notification(team, 91)
      expect(team.survey_status[:second_survey_complete]).to eq nil
    end

    it "tests second_survey_notification where survey threshold is met" do
      team = teams(:team_one)

      #build 10 surveys since team_one has 10 members
      build_surveys(team, "Second Survey", 8)

      #TODO would really like to be testing the mailer here
      Team.second_survey_notification(team, 91)
      expect(team.survey_status[:second_survey_complete]).to eq true
    end
  end

  describe "test third_survey_notification" do
    it "tests third_survey_notification two month nag message to team lead" do
      team = teams(:team_one)
      mail = Team.third_survey_notification(team, 180)
      expect(mail.body).to include("At this time only")
    end

    it "tests third_survey_notification where survey threshold is not met" do
      team = teams(:team_one)

      #build 10 surveys since team_one has 10 members
      build_surveys(team, "Third Survey", 7)

      #TODO would really like to be testing the mailer here
      Team.third_survey_notification(team, 181)
      expect(team.survey_status[:third_survey_complete]).to eq nil
    end

    it "tests third_survey_notification where survey threshold is met" do
      team = teams(:team_one)

      #build 10 surveys since team_one has 10 members
      build_surveys(team, "Third Survey", 8)

      #TODO would really like to be testing the mailer here
      Team.third_survey_notification(team, 181)
      expect(team.survey_status[:third_survey_complete]).to eq true
    end
  end

  describe "test final_survey_notification" do
    it "tests final_survey_notification two month nag message to team lead" do
      team = teams(:team_one)
      mail = Team.final_survey_notification(team, 271)
      expect(mail.body).to include("At this time only")
    end

    it "tests final_survey_notification where survey threshold is not met" do
      team = teams(:team_one)

      #build 10 surveys since team_one has 10 members
      build_surveys(team, "Final Survey", 7)

      #TODO would really like to be testing the mailer here
      Team.final_survey_notification(team, 272)
      expect(team.survey_status[:final_survey_complete]).to eq nil
    end

    it "tests final_survey_notification where survey threshold is met" do
      team = teams(:team_one)

      #build 10 surveys since team_one has 10 members
      build_surveys(team, "Final Survey", 8)

      #TODO would really like to be testing the mailer here
      Team.final_survey_notification(team, 272)
      expect(team.survey_status[:final_survey_complete]).to eq true
    end
  end

  describe "test mailers" do
    it "tests initial_survey_notification and all members have submitted surveys" do
      #directly test the mailer
      team = teams(:team_one)
      mailer = TeamMailer.with(email: "bustas2@wintas.com", team: team.name, slug: team.slug).initial_survey_threshold_met.deliver_now
      expect(mailer.subject).to eq("Team Health Dashboard")
    end    
  end

  def build_surveys(team, phase, number_of_surveys)
    number_of_surveys.times { |i|
      survey = team.surveys.build name: phase
      survey.save
    }
  end
end