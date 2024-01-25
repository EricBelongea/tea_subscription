FactoryBot.define do
  factory :subscription do
    title { Faker::FunnyName.name }
    frequency { Faker::Number.between(from:1, to:20) }
    price { Faker::Number.between(from:1, to:20) }
    status { false }
    # status { Faker::Boolean.boolean }
  end
end