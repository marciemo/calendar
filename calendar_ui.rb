require 'active_record'
require './lib/event'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuation = database_configurations["development"]
ActiveRecord::Base.establish_connection(development_configuation)

def welcome
  puts "Welcome to Simple Scheduler"
  menu
end

def menu
  choice = nil
  until choice == 'x'
    puts "Enter one of the following options:"
    puts "'a' to add an event, 'd' to delete an event, 'e' to edit an event, 'l' to list your events."
    puts "Type 'x' to exit."
    choice = gets.chomp
    case choice
    when 'a'
      add
    when 'd'
      delete
    when 'e'
      edit
    when 'l'
      list
    else
      
    end
  end
end

def add
  puts "Enter a name of your event: "
  event_name = gets.chomp
  puts "Enter a location for your event: "
  event_location = gets.chomp
  puts "Enter a start date and time for your event (Month day year time): "
  start_time = gets.chomp
  puts "Enter an end date and time for your event (Month day year time): "
  end_time = gets.chomp
  event = Event.create!(:name => event_name, :location => event_location, :start_date => start_time, :end_date => end_time)
  puts "'#{event.name}' on '#{event.start_date}' to '#{event.end_date}' has been added to your Scheduler."
end

def delete
  list
  puts "Enter the name of the event you want to delete: "
  event_name = gets.chomp
  Event.where(:name => event_name).pop.destroy
end

def edit

end

def list
  puts "Here are all your events:"
  events = Event.all
  events.each {|event| puts "#{event.name} | #{event.location} | #{event.start_date} | #{event.end_date}"}
end

welcome