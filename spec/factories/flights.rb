FactoryBot.define do
  factory :flight do
    sequence(:name) { |n| "Zagreb-#{n}" }
    no_of_seats 2
    base_price 3
    flys_at { 1.day.from_now }
    lands_at { 2.days.from_now }
    company
  end
end
