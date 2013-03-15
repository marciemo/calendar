require 'spec_helper'

describe Task do
  context 'validations' do
    it {should validate_presence_of :name}
    it { should ensure_length_of(:name).is_at_least(2).is_at_most(25) }
  end

  context 'associations' do
    it {should have_many(:notes)}
  end

  context 'callbacks' do 
    it 'capitalizes the first letter of name' do 
      task = FactoryGirl.create(:task, :name => "not clean the house")
      task.name.should eq "Not clean the house"
    end
  end

  context 'done_scopes' do
    it 'returns all tasks that are incomplete' do
      incomplete_tasks = (1..5).to_a.map {|task| FactoryGirl.create(:task)}
      complete_tasks = (1..5).to_a.map {|task| FactoryGirl.create(:task, :done => true)}
      Task.incomplete.should match_array incomplete_tasks
    end

    it 'returns all tasks that are complete' do
      incomplete_tasks = (1..5).to_a.map {|task| FactoryGirl.create(:task)}
      complete_tasks = (1..5).to_a.map {|task| FactoryGirl.create(:task, :done => true)}
      Task.complete.should match_array complete_tasks
    end
  end
end