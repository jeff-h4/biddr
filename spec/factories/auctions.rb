FactoryGirl.define do
  factory :auction do
    sequence(:title)          { Faker::Commerce.product_name}
    sequence(:details)        { Faker::Hacker.say_something_smart }
    sequence(:ending_date)           { Faker::Date.between(Time.now, Time.now + 10.days) }
    sequence(:reserve_price)  { Faker::Commerce.price }
    current_price             1
  end
end
