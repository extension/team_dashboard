require "rails_helper"

RSpec.describe Team do
	describe "team name" do
		team = Team.new(name: "my team")
    it "creates a new team" do
    	expect(team.name).to eq "my team"
    end
   end
end