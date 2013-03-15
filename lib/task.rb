class Task < ActiveRecord::Base

   validates :name, :presence => true, :length => { :minimum => 2, :maximum => 25 }

   before_save :capitalize

   has_many :notes, :as => :notable

   scope :incomplete, where(:done => nil)
   scope :complete, where(:done => true)

  private 

  def capitalize
    self.name = self.name.capitalize
  end

end