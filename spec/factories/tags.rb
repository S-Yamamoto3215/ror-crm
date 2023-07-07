FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "my-tag-#{n}" }
  end
end
