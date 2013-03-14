class Event < ActiveRecord::Base

  validates :name, :location, :start_date, :end_date, :presence => true
  # validates :start_date, :inclusion => { :in => (Date.today..(Date.today + 36500)) }
  # validates :end_date, :inclusion => { :in => (Date.today..(Date.today + 36500)) }

  scope :after_date, lambda { |time| where("start_date >= ?", time)}
  scope :before_date, lambda { |time| where("start_date <= ?", time)}


end