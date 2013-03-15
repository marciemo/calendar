class Event < ActiveRecord::Base

  validates :name, :location, :start_date, :end_date, :presence => true
  validates :name, :location, :length => { :minimum => 2, :maximum => 25 }

  before_save :capitalize

  # validates :start_date, :inclusion => { :in => (Date.today..(Date.today + 36500)) }
  # validates :end_date, :inclusion => { :in => (Date.today..(Date.today + 36500)) }

  has_many :notes, :as => :notable

  default_scope(:order => :start_date)

  scope :after_date, lambda { |time| where("start_date >= ?", time)}
  scope :before_date, lambda { |time| where("start_date <= ?", time)}

  private 

  def capitalize
    self.name = self.name.capitalize
    self.location = self.location.capitalize
  end

end