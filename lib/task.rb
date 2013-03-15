class Task < ActiveRecord::Base

   validates :name, :presence => true

   has_many :notes, :as => :notable



end