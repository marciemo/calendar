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

  context 'date_scopes' do
    it 'returns all start dates that are after the beginning date' do
      events_after_date = ['20030101', '20040202', '20050204'].map {|date| FactoryGirl.create(:event, :start_date => date)}
      events_before_date = ['10020101', '10030202', '10060204'].map {|date| FactoryGirl.create(:event, :start_date => date)}
      Event.after_date("20010404").should match_array events_after_date
    end

    it 'returns all start dates that are before the beginning date' do
      events_after_date = ['20020101', '20030202', '20060204'].map {|date| FactoryGirl.create(:event, :start_date => date)}
      events_before_date = ['10020101', '10030202', '10060204'].map {|date| FactoryGirl.create(:event, :start_date => date)}
      Event.before_date("20010404").should match_array events_before_date
    end
  end



end