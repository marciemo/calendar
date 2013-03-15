require 'active_record'
require 'rspec'
require 'shoulda-matchers'
require 'factory_girl'
require 'pg'
require './spec/factories'
require 'event'
require 'task'
require 'note'


ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Event.all.each {|event| event.destroy}
    Task.all.each {|task| task.destroy}
  end
end