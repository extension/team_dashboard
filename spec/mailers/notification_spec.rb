require "rails_helper"

RSpec.describe Team do
  fixtures :all

  describe "get_next_survey_notification" do
    it "progress_in_days < 91" do

    end

    it "progress_in_days between 90 & 180" do

    end

    it "progress_in_days between 181 & 270" do

    end

    it "progress_in_days between 271 & 360" do

    end
  end

  describe "initial_survey_notification" do
    it "progress_in_days == 60" do

    end

    it "survey threshold is met" do

    end

  end
end