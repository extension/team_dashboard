require "rails_helper"

RSpec.describe "blarg", :type => :request do
	it "test get_google_form_submission controller action" do
		headers = { "Authorization": "Bearer #{ENV['BEARER_TOKEN']}" }
    post "/responses/get_google_form_submission", :params => 
    {"Your email address"=>"test@wintas.com", "Which survey are you submitting?"=>"Initial Baseline Survey", "Please identify your team:"=>"Project Demeter", "I am comfortable asking the people I work with for help?"=>"1", "I can bring up problems without fear of it being held against me?"=>"1", "I trust the people I work with?"=>"1", "People I work with do what they say they are going to do?"=>"1", "I have the opportunity to learn the skills I need to do my job?"=>"1", "I get what I need from other departments & teams?"=>"1", "I have a clear understanding of what is expected of me?"=>"1", "I know what success looks like in my role?"=>"1", "I have what I need to be successful in my job?"=>"1", "My work is personally fulfilling?"=>"1", "My work allows me to grow as a person?"=>"1", "The work we do here makes a difference in the lives of others?"=>"1", "I get satisfaction from meeting the challenges of my work?"=>"1", "My work allows me to put my skills to use?"=>"1", "My work contributes to the success of this organization?"=>"3", "response"=>{}},
    :headers => headers
    puts "team in test is: " + Team.last.inspect
    expect(User.last.email).to eq 'test@wintas.com'
    expect(Survey.last.name).to eq 'Initial Baseline Survey'
    expect(Team.last.name).to eq 'Project Demeter'
    expect(Response.last.score).to eq 3
   end
end