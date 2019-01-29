RSpec.describe 'Users API', type: :request do
  describe 'GET /api/users' do
    before { FactoryBot.create_list(:user, 3) }

    it 'returns 200 OK' do
      get '/api/users'
      expect(response).to have_http_status(:ok)
    end
    it 'returns expected length' do
      get '/api/users'
      json_body = JSON.parse(response.body)
      expect(json_body['users'].length).to eq(3)
    end
  end

  describe 'GET /api/users/:id' do
    let(:user) { FactoryBot.create(:user) }

    it 'returns 200 OK' do
      get "/api/users/#{user.id}"
      expect(response).to have_http_status(:ok)
    end
    it 'returns a response containing attributes ' do
      get "/api/users/#{user.id}"
      json_body = JSON.parse(response.body)
      expect(json_body['user'].empty?).to be(false)
    end
  end

  describe 'POST /api/users' do
    context 'when params are valid' do
      it 'creates a user' do
        expect do
          post '/api/users',
               params: {
                 user: { first_name: 'ime',
                         email: 'ime@gmail.com' }
               }
        end.to change(User, :count).by(1)
      end

      it 'returns 201 CREATED' do
        post '/api/users', params: {
          user: { first_name: 'ime',
                  email: 'ime@gmail.com' }
        }
        expect(response).to have_http_status(:created)
      end

      it 'returns a response containing attributes' do
        post '/api/users',
             params: {
               user: { first_name: 'ime',
                       email: 'ime@gmail.com' }
             }
        json_body = JSON.parse(response.body)
        expect(json_body['user']).to include('first_name' => 'ime')
      end
    end
  end

  describe 'DELETE /api/users/:id' do
    let!(:user_del) { FactoryBot.create(:user) }

    it 'returns 204 NO_CONTENT' do
      delete "/api/users/#{user_del.id}"
      expect(response).to have_http_status(:no_content)
    end
    it 'has 1 element less' do
      expect do
        delete "/api/users/#{user_del.id}"
      end.to change(User, :count).by(-1)
    end
  end

  describe 'PATCH /api/users' do
    let(:user_upd) { FactoryBot.create(:user) }

    it 'updates a user' do
      patch "/api/users/#{user_upd.id}",
            params: {
              user: {
                name: 'focus'
              }
            }
      expect(response).to have_http_status(:ok)
    end
  end
end
