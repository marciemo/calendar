require 'spec_helper'

describe Note do 
  context 'validations' do
    it {should validate_presence_of :entry}
    it { should ensure_length_of(:entry).is_at_least(2).is_at_most(100) }
  end

  context 'associations' do
    it {should belong_to :notable}
  end



end