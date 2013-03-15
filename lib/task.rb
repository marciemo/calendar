class Task < ActiveRecord::Base

   validates :name, :presence => true

   has_many :notes, :as => :notable

   scope :incomplete, where(:done => nil)
   scope :complete, where(:done => true)

end