RSpec.describe 'Companies API', type: :request do
  describe 'GET /api/companies' do
    before { FactoryBot.create_list(:company, 3) }

    it 'returns 200 OK' do
      get '/api/companies'
      expect(response).to have_http_status(:ok)
    end

    it 'returns expected length' do
      get '/api/companies'
      json_body = JSON.parse(response.body)
      expect(json_body['companies'].length).to eq(3)
    end
  end

  describe 'GET /api/companies/:id' do
    let(:company) { FactoryBot.create(:company) }

    it 'returns 200 OK' do
      get "/api/companies/#{company.id}"
      expect(response).to have_http_status(:ok)
    end

    it 'returns a response containing attributes ' do
      get "/api/companies/#{company.id}"
      json_body = JSON.parse(response.body)
      expect(json_body['company'].empty?).to be(false)
    end
  end

  describe 'POST /api/companies' do
    context 'when params are valid' do
      it 'creates a company' do
        expect do
          post '/api/companies',
               params: {
                 company: { name: 'ime tvrtke' }
               }
        end.to change(Company, :count).by(1)
      end

      it 'returns 201 CREATED' do
        post '/api/companies', params: { company: { name: 'nekoime' } }
        expect(response).to have_http_status(:created)
      end

      it 'returns a response containing attributes' do
        post '/api/companies',
             params: {
               company: {
                 name: 'nekoime'
               }
             }
        json_body = JSON.parse(response.body)
        expect(json_body['company']).to include('name' => 'nekoime')
      end
    end
  end

  describe 'DELETE /api/companies/:id' do
    let!(:company_del) { FactoryBot.create(:company) }

    it 'returns 204 NO_CONTENT' do
      delete "/api/companies/#{company_del.id}"
      expect(response).to have_http_status(:no_content)
    end
    it 'has 1 element less' do
      expect do
        delete "/api/companies/#{company_del.id}"
      end.to change(Company, :count).by(-1)
    end
  end

  describe 'PATCH /api/companies' do
    let(:company_upd) { FactoryBot.create(:company) }

    it 'updates a company' do
      patch "/api/companies/#{company_upd.id}",
            params: {
              company: {
                name: 'focus'
              }
            }
      expect(response).to have_http_status(:ok)
    end
  end
end
