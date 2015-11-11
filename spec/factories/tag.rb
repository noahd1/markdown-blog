FactoryGirl.define do
  factory :tag do
    title Faker::Book.title
    description Faker::Lorem.sentence
  end
end
