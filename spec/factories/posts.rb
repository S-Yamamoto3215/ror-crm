FactoryBot.define do
  factory :post do
    title { 'My Title' }
    body { 'My Body. My Body' }
    sequence(:slug) { |n| "my-title-#{n}" }
    user

    trait :invalid do
      title { nil }
    end
  end
end
