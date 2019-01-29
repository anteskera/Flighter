FactoryBot.define do
  factory :user do
    first_name 'Ricky'
    last_name 'Martin'
    sequence(:email) { |n| "ricky.martin-#{n}@gmail.com" }
  end
end
