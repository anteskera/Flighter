RSpec.describe 'Flights API', type: :request do
  describe 'GET /api/flights' do
    before { FactoryBot.create_list(:flight, 3) }

    it 'returns status 200 OK' do
      get '/api/flights'
      expect(response).to have_http_status(:ok)
    end
    it 'returns expected length' do
      get '/api/flights'
      json_body = JSON.parse(response.body)
      expect(json_body['flights'].length).to eq(3)
    end
  end

  describe 'GET /api/flights/:id' do
    let(:flight) { FactoryBot.create(:flight) }

    it 'returns 200 OK' do
      get "/api/flights/#{flight.id}"
      expect(response).to have_http_status(:ok)
    end
    it 'returns a response containing attributes' do
      get "/api/flights/#{flight.id}"
      json_body = JSON.parse(response.body)
      expect(json_body['flight'].empty?).to eq(false)
    end
  end

  describe 'POST /api/flights' do
    context 'when params are valid' do
      let(:company) { FactoryBot.create(:company) }

      it 'creates a flight' do
        expect do
          post '/api/flights',
               params: {
                 flight: { name: 'ime leta', no_of_seats: 150, base_price: 250,
                           flys_at: 1.day.from_now, lands_at: 2.days.from_now,
                           company_id: company.id }
               }
        end.to change(Flight, :count).by(1)
      end

      it 'returns 200 OK' do
        post '/api/flights',
             params: {
               flight: { name: 'ime leta', no_of_seats: 150, base_price: 250,
                         flys_at: 1.day.from_now, lands_at: 2.days.from_now,
                         company_id: company.id }
             }
        expect(response).to have_http_status(:created)
      end

      it 'returns response containing attributes' do
        post '/api/flights',
             params: {
               flight: { name: 'ime leta', no_of_seats: 150, base_price: 250,
                         flys_at: 1.day.from_now, lands_at: 2.days.from_now,
                         company_id: company.id }
             }
        json_body = JSON.parse(response.body)
        expect(json_body['flight']).to include('name' => 'ime leta')
      end
    end
  end

  describe 'DELETE /api/flights/:id' do
    let!(:flight_del) { FactoryBot.create(:flight) }

    it 'returns 204 NO_CONTENT' do
      delete "/api/flights/#{flight_del.id}"
      expect(response).to have_http_status(:no_content)
    end
    it 'has 1 element less' do
      expect do
        delete "/api/flights/#{flight_del.id}"
      end.to change(Flight, :count).by(-1)
    end
  end

  describe 'PATCH /api/flights/:id' do
    let(:flight) { FactoryBot.create(:flight) }

    it 'updates a flight' do
      patch "/api/flights/#{flight.id}",
            params: {
              flight: {
                name: 'focus'
              }
            }

      expect(response).to have_http_status(:ok)
    end
  end
end
