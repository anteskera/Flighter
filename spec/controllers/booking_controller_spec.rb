RSpec.describe 'Bookings API', type: :request do
  describe 'GET /api/bookings' do
    before { FactoryBot.create_list(:booking, 3) }

    it 'returns 200 OK' do
      get '/api/bookings'
      expect(response).to have_http_status(:ok)
    end

    it 'returns expected length' do
      get '/api/bookings'
      json_body = JSON.parse(response.body)
      expect(json_body['bookings'].length).to eq(3)
    end
  end

  describe 'GET /api/bookings/:id' do
    let(:booking) { FactoryBot.create(:booking) }

    it 'returns 200 OK' do
      get "/api/bookings/#{booking.id}"
      expect(response).to have_http_status(:ok)
    end

    it 'returns a response containing attributes ' do
      get "/api/bookings/#{booking.id}"
      json_body = JSON.parse(response.body)
      expect(json_body['booking'].empty?).to be(false)
    end
  end

  describe 'POST /api/bookings' do
    let(:flight) { FactoryBot.create(:flight) }
    let(:user) { FactoryBot.create(:user) }

    context 'when params are valid' do
      it 'creates a booking' do
        expect do
          post '/api/bookings',
               params: {
                 booking: {
                   seat_price: 159, no_of_seats: 1,
                   user_id: user.id, flight_id: flight.id
                 }
               }
        end.to change(Booking, :count).by(1)
      end

      it 'returns 201 CREATED' do
        post '/api/bookings',
             params: {
               booking: {
                 seat_price: 159, no_of_seats: 1,
                 user_id: user.id, flight_id: flight.id
               }
             }
        expect(response).to have_http_status(:created)
      end

      it 'returns a response containing attributes' do
        post '/api/bookings',
             params: {
               booking: {
                 seat_price: 159, no_of_seats: 1,
                 user_id: user.id, flight_id: flight.id
               }
             }
        json_body = JSON.parse(response.body)
        expect(json_body['booking']).to include('seat_price' => 159)
      end
    end
  end

  describe 'DELETE /api/bookings/:id' do
    let!(:booking_del) { FactoryBot.create(:booking) }

    it 'returns 204 NO_CONTENT' do
      delete "/api/bookings/#{booking_del.id}"
      expect(response).to have_http_status(:no_content)
    end
    it 'has 1 element less' do
      expect do
        delete "/api/bookings/#{booking_del.id}"
      end.to change(Booking, :count).by(-1)
    end
  end

  describe 'PATCH /api/bookings' do
    let(:booking_upd) { FactoryBot.create(:booking) }

    it 'updates a booking' do
      patch "/api/bookings/#{booking_upd.id}",
            params: {
              booking: {
                name: 'focus'
              }
            }
      expect(response).to have_http_status(:ok)
    end
  end
end
