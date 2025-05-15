require "rails_helper"

RSpec.describe 'ApplicationController', type: :controller do
  let(:user) { create(:user) }
  let(:token) { TokenManager::JsonWebTokenManager.encode({ user_id: user.id }) }
  let(:headers) { { "Authorization" => "Bearer #{token}" } }

  controller do
    def fake_action
      head :no_content
    end
  end

  before { routes.draw { get '/fake_action' => 'anonymous#fake_action' } }

  subject { get :fake_action }

  describe 'should authenticate a request with a valid token' do
    before do
      request.headers.merge! headers
    end

    it 'authenticates successfully and returns a 204 status code' do
      subject
      expect(response.code).to eq('204')
    end
  end

  describe 'should reject a request without the Authorization header' do
    before do
      request.headers.merge!({ 'wrong_header' => "Bearer #{token}" })
    end

    it 'rejects the request with a 401 status code' do
      subject
      expect(response.code).to eq('401')
    end
  end

  describe 'should reject a request with an invalid token' do
    before do
      request.headers.merge!({ 'Authorization' => 'Bearer wrong_token' })
    end

    it 'rejects the request with a 401 status code' do
      subject
      expect(response.code).to eq('401')
    end
  end

  describe 'should reject a request without bearer scheme' do
    before do
      request.headers.merge!({ 'Authorization' => "WRONG_SCHEME #{token}" })
    end

    it 'rejects the request with a 401 status code' do
      subject
      expect(response.code).to eq('401')
    end
  end

  describe 'should reject expired token' do
    before do
      request.headers.merge({
        'Authorization' => "Bearer #{TokenManager::JsonWebTokenManager.encode({ user_id: user.id }, 3.months.ago)}"
      })
    end

    it 'rejects the token, returning a 401 status code and UNAUTHORIZED error' do
      subject
      expect(response.code).to eq('401')
      expect(response.parsed_body['errors']).to eq('UNAUTHORIZED')
    end
  end
end
