class Note < ActiveRecord::Base

  validates :entry, :presence => true, :length => { :minimum => 2, :maximum => 100 }

  
  belongs_to :notable, :polymorphic => true

end
