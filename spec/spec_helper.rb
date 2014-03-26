require 'rspec'
require 'active_record'
require 'survey'
require 'question'
require 'choice'
require 'response'
require 'shoulda-matchers'

database_configurations = YAML::load(File.open('./db/config.yml'))
test_configuration = database_configurations['test']
ActiveRecord::Base.establish_connection(test_configuration)

RSpec.configure do |config|
  config.after(:each) do
    Question.all.each { |question| question.destroy }
    Survey.all.each { |survey| survey.destroy }
    Choice.all.each { |choice| choice.destroy }
    Response.all.each { |response| response.destroy }
  end
end
