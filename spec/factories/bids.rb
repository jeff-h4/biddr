FactoryGirl.define do

  factory :bid do
    sequence(:amount) { Faker::Commerce.price }
  end


end
