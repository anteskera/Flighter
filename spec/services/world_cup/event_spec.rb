RSpec.describe WorldCup::Event do
  let(:event_test) do
    described_class.new(
      'id' => 5,
      'type_of_event' => 'goal',
      'player' => 'Iury GAZINSKY',
      'time' => "12'"
    )
  end

  it 'initializes id' do
    expect(event_test.id).to eq(5)
  end
  it 'initializes type of event' do
    expect(event_test.type).to eq('goal')
  end
  it 'initializes player' do
    expect(event_test.player).to eq('Iury GAZINSKY')
  end
  it 'initializes time' do
    expect(event_test.time).to eq("12'")
  end
  it 'converts to string' do
    expect(event_test.to_s).to eq("#5: goal@12' - Iury GAZINSKY")
  end
end
