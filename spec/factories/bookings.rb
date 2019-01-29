FactoryBot.define do
  factory :booking do
    seat_price 3
    no_of_seats 2
    flight
    user
  end
end
