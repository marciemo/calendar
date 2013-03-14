class Event < ActiveRecord::Base

  validates :name, :location, :start_date, :end_date, :presence => true
  # validates :start_date, :inclusion => { :in => (Date.today..(Date.today + 36500)) }
  # validates :end_date, :inclusion => { :in => (Date.today..(Date.today + 36500)) }


end