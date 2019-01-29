RSpec.describe Flight, type: :model do
  subject { FactoryBot.build(:flight) }

  it { is_expected.to validate_presence_of(:name) }
  it do
    is_expected.to validate_uniqueness_of(:name)
      .scoped_to(:company_id)
      .case_insensitive
  end
  it { is_expected.to validate_presence_of(:lands_at) }
  it { is_expected.to validate_presence_of(:flys_at) }
  it { is_expected.to validate_numericality_of(:no_of_seats) }
  it { is_expected.to validate_numericality_of(:base_price) }

  it 'is supposed to fly before landing' do
    flight = FactoryBot.build(:flight,
                              flys_at: 15.days.ago,
                              lands_at: 16.days.ago)
    flight.valid?
    expect(flight.flys_before_landing).to include('must fly before landing')
  end
end
