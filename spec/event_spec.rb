require 'spec_helper'

describe Event do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should ensure_length_of(:name).is_at_least(2).is_at_most(25) }
    it { should validate_presence_of :location }
    it { should ensure_length_of(:name).is_at_least(2).is_at_most(25) }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
  end

  context 'associations' do
    it {should have_many(:notes)}
  end

  context 'callbacks' do 
    it 'capitalizes the first letter of name' do 
      event = FactoryGirl.create(:event, :name => "party")
      event.name.should eq "Party"
    end

    it 'capitalizes the first letter of location' do 
      event = FactoryGirl.create(:event, :location => "here")
      event.location.should eq "Here"
    end
  end

    context 'date_validation' do
    it 'ensures that a start date cannot be after an end date' do 
      event = FactoryGirl.build(:event, :start_date => 'March 15, 2013 4:00pm', :end_date => 'March 10, 2012 4:00pm')
      event.should_not be_valid
    end
  end

  context 'scopes' do
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

    it 'by default sorts events by start_date' do
      event_dates = ['20130101 13:00', '20130202', '20130204', '20130102', '20130101 06:00'].map {|date| FactoryGirl.create(:event, :start_date => date)}
      Event.all.should eq event_dates.sort_by { |event| event.start_date }
    end
  end



end