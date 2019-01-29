RSpec.describe Booking, type: :model do
  subject { FactoryBot.build(:booking) }

  it { is_expected.to validate_presence_of(:seat_price) }
  it { is_expected.to validate_numericality_of(:seat_price) }
  it { is_expected.to validate_presence_of(:no_of_seats) }
  it { is_expected.to validate_numericality_of(:no_of_seats) }

  it 'is supposed to book a flight in the future' do
    flight = FactoryBot.build(:flight,
                              flys_at: 1.day.ago,
                              lands_at: 1.day.from_now)
    bookin = FactoryBot.build(:booking, flight: flight)
    bookin.valid?
    expect(bookin.flys_in_future).to include("flights can't happen in the past")
  end
end
