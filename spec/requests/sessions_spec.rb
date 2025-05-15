require "rails_helper"

RSpec.describe 'Sessions API', type: :request do
  let!(:user) { create(:user, email: "sam@gmail.com") }

  describe 'post /v1/sessions' do
    context 'with valid credentails' do
      it 'returns a JWT token' do
        post '/v1/sessions', params: { email: "sam@gmail.com", password: "password" }

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)

        expect(json["token"]).to be_present
      end
    end

    context 'with invalid credentials' do
      it 'returns not found for missing user' do
        post '/v1/sessions', params: { email: "nobody@now.com", password: "yahoo" }

        expect(response).to have_http_status(:not_found)
        json = JSON.parse(response.body)
        expect(json["errors"]).to be_present
      end

      it 'returns unauthorized for invalid password' do
        post '/v1/sessions', params: { email: "sam@gmail.com", password: "harbour" }

        expect(response).to have_http_status(:unauthorized)
        json = JSON.parse(response.body)

        expect(json["errors"]).to eq('UNAUTHORIZED')
      end
    end
  end
end
