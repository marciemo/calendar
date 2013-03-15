require 'active_record'
require './lib/event'
require './lib/task'
require './lib/note'


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
    puts "Choose 'c' to go to your calendar or 't' to go to your task list."
    puts "Type 'x' to exit."
    choice = gets.chomp 
    case choice
    when 'c'
      calendar_menu
    when 't'
      task_menu
    else
    end
  end
end


def calendar_menu
  choice = nil
  until choice == 'x'
    puts "Enter one of the following options:"
    puts "'a' to add an event, 'd' to delete an event, 'v' to view my schedule by date range, 'l' to list your events."
    puts "Type 'x' to exit."
    choice = gets.chomp
    case choice
    when 'a'
      add_event
    when 'd'
      delete_event
    when 'v'
      view_events
    when 'l'
      list_events(Event.all)
    else
    end
  end
end

def task_menu
  choice = nil
  until choice == 'x'
    puts "Enter one of the following options:"
    puts "'a' to add a task, 'd' to delete a task, 'c' to mark task as complete, 'l' to list all tasks."
    puts "Type 'x' to exit."
    choice = gets.chomp
    case choice
    when 'a'
      add_task
    when 'd'
      delete_task
    when 'c'
      complete_task
    when 'l'
      list_tasks(Task.all)
    else
    end
  end
end 

def add_event
  puts "Enter a name of your event: "
  event_name = gets.chomp
  puts "Enter a location for your event: "
  event_location = gets.chomp
  puts "Enter a start date and time for your event (Month day, year time): "
  start_time = gets.chomp
  puts "Enter an end date and time for your event (Month day, year time): "
  end_time = gets.chomp
 
  event = Event.create(:name => event_name, :location => event_location, :start_date => start_time, :end_date => end_time)
  puts "'#{event.name}' on '#{event.start_date}' to '#{event.end_date}' has been added to your Scheduler."
  puts "Would you like to add a note to this task? (y/n)"
  answer = gets.chomp
  if answer == 'y'
    puts "Please enter your note here: \n\n"
    entry = gets.chomp
    note = event.notes.create(:entry => entry)
    puts "Note added"
  else
  end
end

def list_events(events)
  puts "Here are all your events:"
  events.each {|event| puts "#{event.name}\t|\t#{event.location}\t|\t#{event.start_date}\t|\t#{event.end_date}\n\n"}
end

def delete_event
  list_events(Event.all)
  puts "Enter the name of the event you want to delete: "
  event_name = gets.chomp
  Event.where(:name => event_name).pop.destroy
end

def view_events
  puts "Enter a start date (Month day, year): "
  start_time = Date.parse(gets.chomp)
  puts "Enter an end date (Month day, year): "
  end_time = Date.parse(gets.chomp)
  events = Event.after_date(start_time).before_date(end_time)
  list_events(events)
end

def add_task
  puts "Enter a name for your task: "
  task_name = gets.chomp
  task = Task.create(:name => task_name)
  puts "'#{task.name}' has been added to your Scheduler."
end

def list_tasks(tasks)
  puts "Here are all your tasks:"
  tasks.each {|task| puts "#{task.name}"}
end

def delete_task
  list_tasks(Task.all)
  puts "Enter the name of the task you wish to delete: "
  task_name = gets.chomp
  Task.where(:name => task_name).pop.destroy
end

def complete_tasks
  list_tasks(Task.all)
  puts "Enter the name of the task you wish to mark as complete: "
  task_name = gets.chomp
  Task.where(:name => task_name).pop
end



welcome