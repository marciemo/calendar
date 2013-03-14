require 'spec_helper'

describe Event do
  context 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :location}
    it {should validate_presence_of :start_date}
    it {should validate_presence_of :end_date}


    # it { should allow_value(Date.today).for(:start_date) }
    # it { should_not allow_value(1.days.ago).for(:start_date) }
    # it { should allow_value(Date.today).for(:end_date) }
    # it { should_not allow_value(1.days.ago).for(:end_date) }

  end

end