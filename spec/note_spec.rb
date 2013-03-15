require 'spec_helper'

describe Note do 
  context 'validations' do
    it {should validate_presence_of :entry}
  end

  context 'associations' do
    it {should belong_to :notable}
  end



end