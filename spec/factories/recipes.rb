FactoryBot.define do
  factory :recipe do
     title { Faker::Lorem.characters(number:20) }
    user
  end
end
