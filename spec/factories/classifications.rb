FactoryBot.define do
  factory :classification do
    association :post
    association :tag
  end
end
