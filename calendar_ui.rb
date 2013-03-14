require 'active_record'
require './lib/event'
require './lib/task'

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
    puts "'a' to add an event, 'd' to delete an event, 'v' to view my schedule by day, 'l' to list your events."
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
    puts "'a' to add a task, 'd' to delete a task, 'v' to view tasks by date range, 'l' to list all tasks."
    puts "Type 'x' to exit."
    choice = gets.chomp
    case choice
    when 'a'
      add_task
    when 'd'
      delete_task
    when 'v'
      view_tasks
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
  puts "Enter a start date and time for your event (Month day year time): "
  start_time = gets.chomp
  puts "Enter an end date and time for your event (Month day year time): "
  end_time = gets.chomp
  event = Event.create!(:name => event_name, :location => event_location, :start_date => start_time, :end_date => end_time)
  puts "'#{event.name}' on '#{event.start_date}' to '#{event.end_date}' has been added to your Scheduler."
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
  puts "Enter a date and time for your calendar (Month day year time): "
  start_time = Date.parse(gets.chomp)
  puts "Enter an end date and time for your calendar (Month day year time): "
  end_time = Date.parse(gets.chomp)

  time_frame = Event.where("start_date >= ? AND end_date <= ?", start_time, end_time)
  list(time_frame)

end

def add_task
  puts "Enter a name of your task: "
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


welcome