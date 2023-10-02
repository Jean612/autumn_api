FactoryBot.define do
  factory :user do
    name      { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email     { Faker::Internet.email }
    password  { Faker::Internet.password }
  end

  trait :admin do
    admin { true }
  end
end
