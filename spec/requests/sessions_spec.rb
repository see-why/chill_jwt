require "rails_helper"

RSpec.describe 'Sessions API', type: :request do
  let!(:user) { create(:user, email: "sam@gmail.com") }

  describe 'post /v1/sessions' do
    subject do
      post '/v1/sessions', params: {
        email: email,
        password: password
      }
    end

    context 'with valid credentails' do
      let(:password) { "password" }
      let(:email) { "sam@gmail.com" }

      it 'returns a JWT token' do
        subject

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)

        expect(json["token"]).to be_present
      end
    end

    context 'with invalid email' do
      let(:password) {  "yahoo" }
      let(:email) { "jon@gmail.com" }

      it 'returns not found for missing user' do
        subject

        expect(response).to have_http_status(:not_found)
        json = JSON.parse(response.body)

        expect(json["errors"]).to be_present
      end
    end

    context 'with invalid password' do
      let(:password) { "harbour" }
      let(:email) { "sam@gmail.com" }

      it 'returns unauthorized' do
        subject

        expect(response).to have_http_status(:unauthorized)
        json = JSON.parse(response.body)

        expect(json["errors"]).to eq('UNAUTHORIZED')
      end
    end
  end
end
