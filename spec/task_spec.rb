require 'spec_helper'

describe Task do
  context 'validations' do
    it {should validate_presence_of :name}
  end

  context 'associations' do
    it {should have_many(:notes)}
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