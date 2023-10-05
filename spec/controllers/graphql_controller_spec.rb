require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do
  let(:valid_autumn_token) { ENV['AUTUMN_TOKEN'] }
  let(:invalid_autumn_token) { 'invalid_token' }
  let(:user_query_string) { '{ user { id } }' }


  describe '#execute' do
    it 'returns 401 if AUTUMN_TOKEN is invalid' do
      request.headers['HTTP_AUTUMN_TOKEN'] = invalid_autumn_token

      post :execute, params: { query: user_query_string }

      expect(response).to have_http_status(:unauthorized) # 401
    end

    it 'returns 200 if AUTUMN_TOKEN is VALID' do
      request.headers['HTTP_AUTUMN_TOKEN'] = valid_autumn_token

      post :execute, params: { query: user_query_string }

      expect(response).to have_http_status(:ok) # 200
    end
  end

  describe '#token_valid?' do
    before do
      ENV['AUTUMN_TOKEN'] = valid_autumn_token
    end

    it 'returns false if AUTUMN_TOKEN is invalid' do
      request.headers['HTTP_AUTUMN_TOKEN'] = invalid_autumn_token

      expect(controller.send(:token_valid?)).to be(false)
    end

    it 'returns true if AUTUMN_TOKEN is valid' do
      request.headers['HTTP_AUTUMN_TOKEN'] = valid_autumn_token

      expect(controller.send(:token_valid?)).to be(true)
    end
  end

end
