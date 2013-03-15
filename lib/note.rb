class Note < ActiveRecord::Base

  validates :entry, :presence => true
  
  belongs_to :notable, :polymorphic => true

end
