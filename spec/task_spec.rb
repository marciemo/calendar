require 'spec_helper'

describe Task do
  context 'validations' do
    it {should validate_presence_of :name}
  end
end