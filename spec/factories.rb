FactoryGirl.define do
  factory :event do
    name 'Clean out sock drawer' 
    location 'Home'
    start_date 'March 29th, 2013 9:00am'
    end_date 'March 29th, 2013 11:00am'
  end

  factory :task do
    name 'Go running'
    done nil
  end
end