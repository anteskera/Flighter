RSpec.describe WorldCup::Match do
  let(:match) do
    described_class.new(
      'venue' => 'Moscow',
      'status' => 'completed',
      'home_team' => {
        'country' => 'Uruguay',
        'code' => 'URU',
        'goals' => 1
      },
      'away_team' => {
        'country' => 'Saudi Arabia',
        'code' => 'KSA',
        'goals' => 0
      },
      'datetime' => '2018-06-14T15:00:00Z',
      'home_team_events' => [
        {
          'id' => 5,
          'type_of_event' => 'goal',
          'player' => 'Iury GAZINSKY',
          'time' => "12'"
        },
        {
          'id' => 1,
          'type_of_event' => 'substitution-in',
          'player' => 'Denis CHERYSHEV',
          'time' => "24'"
        },
        {
          'id' => 320,
          'type_of_event' => 'substitution-out',
          'player' => 'Alan DZAGOEV',
          'time' => "24'"
        }
      ],
      'away_team_events' => [
        {
          'id' => 12,
          'type_of_event' => 'substitution-in',
          'player' => 'FAHAD ALMUWALLAD',
          'time' => "64'"
        },
        {
          'id' => 325,
          'type_of_event' => 'substitution-out',
          'player' => 'ABDULLAH OTAYF',
          'time' => "64'"
        }
      ]
    )
  end

  it 'initializes venue' do
    expect(match.venue).to eq('Moscow')
  end

  it 'initializes status' do
    expect(match.status).to eq('completed')
  end

  it 'initializes starts_at' do
    expect(match.starts_at).to eq('2018-06-14 15:00:00 +0000')
  end

  it 'initializes home team' do
    expect(match.home_team).to eq(
      'country' => 'Uruguay',
      'code' => 'URU',
      'goals' => 1
    )
  end

  it 'initializes away team' do
    expect(match.away_team).to eq(
      'country' => 'Saudi Arabia',
      'code' => 'KSA',
      'goals' => 0
    )
  end

  it 'is proper length' do
    expect(match.events.length).to eq(5)
  end

  it 'is instance of Event' do
    expect(match.events).to all(be_an(WorldCup::Event))
  end

  it 'is proper length of goals' do
    expect(match.goals.length).to eq(1)
  end
end
