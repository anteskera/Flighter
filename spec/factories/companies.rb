FactoryBot.define do
  factory :company do
    sequence(:name) { |n| "Croatia#{n}" }
  end
end
