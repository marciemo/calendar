class Event < ActiveRecord::Base
  
  validates :name, :location, :start_date, :end_date, :presence => true
  validates :name, :location, :length => { :minimum => 2, :maximum => 25 }
  
  validate :date_validation

  before_save :capitalize

  has_many :notes, :as => :notable

  default_scope(:order => :start_date)

  scope :after_date, lambda { |time| where("start_date >= ?", time)}
  scope :before_date, lambda { |time| where("start_date <= ?", time)}

  private

  def date_validation
    unless end_date.nil? || start_date.nil?
      errors.add(:end_date, "must be after start date") if end_date < start_date
    end 
  end

  def capitalize
    self.name = self.name.capitalize
    self.location = self.location.capitalize
  end

end
