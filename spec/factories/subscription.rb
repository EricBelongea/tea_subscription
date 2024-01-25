FactoryBot.define do
  factory :subscription do
    title { Faker::FunnyName.name }
    frequency { Faker::Number.between(from:1, to:20) }
    price { Faker::Number.between(from:1, to:20) }
    status { Faker::Boolean.boolean(true_ratio: 0.5) }
  end
end