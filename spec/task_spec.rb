require 'spec_helper'

describe Task do
  context 'validations' do
    it {should validate_presence_of :name}
  end

  context 'associations' do
    it {should have_many(:notes)}
  end

  context '#mark_done' 
    it 'marks a task as done in the task list' 

  
end