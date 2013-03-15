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
    puts "Enter one of the following event options:"
    puts "'a' to add, 'e' to edit, 'd' to delete, 'v' to view schedule by date range, 'l' to list all events."
    puts "Type 'x' to exit."
    choice = gets.chomp
    case choice
    when 'a'
      add_event
    when 'e'
      edit_event
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
    puts "Enter one of the following task options:"
    puts "'a' to add, 'e' to edit, 'd' to delete, 'c' to mark as complete, 'l' to list all tasks."
    puts "Type 'x' to exit."
    choice = gets.chomp
    case choice
    when 'a'
      add_task
    when 'e'
      edit_task
    when 'd'
      delete_task
    when 'c'
      complete_task
    when 'l'
      puts "Here are your completed tasks:"      
      list_tasks(Task.complete)
      puts "Here are your incomplete tasks:"
      list_tasks(Task.incomplete)
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
  answer = nil
  until answer == 'n'
    puts "Would you like to add a note? (y/n)"
    answer = gets.chomp
    case answer
    when 'y'
      puts "Please enter your note here: \n\n"
      entry = gets.chomp
      note = event.notes.create(:entry => entry)
      puts "Note added."
    else
    end
  end
end

def edit_event
  list_events(Event.all)
  puts "Enter the name of the event you want to edit."
  event_name = gets.chomp
  event = Event.where(:name => event_name).pop
  puts "#{event.name}\t#{event.location}\t#{event.start_date}\t#{event.end_date}\t#{event.notes.map {|note| note.entry}.join(', ')}"
  choice = nil
  until choice == 'x'
    puts "Enter one of the following event edit functions:"
    puts "'1' to edit name, '2' to edit location, '3' to edit start date, '4' to edit end date, '5' to add another note, 'x' to exit"
    choice = gets.chomp
    case choice
    when '1'
      puts "Enter a new name: "
      name = gets.chomp
      Event.where(:name => event_name).pop.update_attributes(:name => name)
      list_events(Event.all)      
    when '2'
      puts "Enter a new location: "
      location = gets.chomp
      Event.where(:name => event_name).pop.update_attributes(:location => location)
      list_events(Event.all)
    when '3'
      puts "Enter a new start_date: "
      start_date = gets.chomp
      Event.where(:name => event_name).pop.update_attributes(:start_date => start_date)
      list_events(Event.all)
    when '4'
      puts "Enter a new end_date: "
      end_date = gets.chomp
      Event.where(:name => event_name).pop.update_attributes(:end_date => end_date)
      list_events(Event.all)
    when '5'
      puts "Enter a new note\n\n"
      new_note = gets.chomp
      note = event.notes.create(:entry => new_note)
      list_events(Event.all)      
    else
    end
  end
end

def list_events(events)
  puts "Here are all your events:"
  events.each {|event| puts "#{event.name}\t#{event.location}\t#{event.start_date}\t#{event.end_date}\t#{event.notes.map {|note| note.entry}.join(', ')}\n\n"}
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
  answer = nil
  until answer == 'n'
    puts "Would you like to add a note? (y/n)"
    answer = gets.chomp
    case answer
    when 'y'
      puts "Please enter your note here: \n\n"
      entry = gets.chomp
      note = task.notes.create(:entry => entry)
      puts "Note added."
    else
    end
  end
end

def edit_task
  list_tasks(Task.all)
  puts "Enter the name of the task you want to edit."
  task_name = gets.chomp
  task_to_edit = Task.where(:name => task_name).pop
  puts "#{task_to_edit.name}\t#{task_to_edit.notes.map { |note| note.entry }.join(', ')}"
  choice = nil
  until choice == 'x'
    puts "Enter one of the following task edit functions:"
    puts "'1' to edit name, '2' to add another note, 'x' to exit"
    choice = gets.chomp
    case choice
    when '1'
      puts "Enter a new name: "
      name = gets.chomp
      Task.where(:name => task_name).pop.update_attributes(:name => name)
      puts "Here is your updated tasks: "
      list_tasks(Task.all)
    when '2'
      puts "Enter a new note\n\n"
      new_note = gets.chomp
      note = task_to_edit.notes.create(:entry => new_note)
      list_tasks(Task.all)      
    else
    end
  end
end

def list_tasks(tasks)
  tasks.each {|task| puts "#{task.name}\t#{task.notes.map { |note| note.entry }.join(', ')}"}
end

def delete_task
  list_tasks(Task.all)
  puts "Enter the name of the task you wish to delete: "
  task_name = gets.chomp
  Task.where(:name => task_name).pop.destroy
end

def complete_task
  list_tasks(Task.all)
  puts "Enter the name of the task you wish to mark as complete: "
  task_name = gets.chomp
  Task.where(:name => task_name).pop.update_attributes(:done => true)
end



welcome