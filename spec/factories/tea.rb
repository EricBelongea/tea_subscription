FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Tea.type }
    temperature { Faker::Number.between(from:100, to:212) }
    brew_time { Faker::Number.between(from:2, to:10) }
  end
end