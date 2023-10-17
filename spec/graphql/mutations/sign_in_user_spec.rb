require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe GraphqlController, '#sign_in_user', type: :controller do
  include GraphqlHelper
  include_context(:user)

  let(:mutation) do
    <<-GRAPHQL
      mutation signInUser(
        $input: SignInUserInput!
      ) {
        signInUser(
          input: $input
        ) {
          data {
            id
            email
            token
          }
        }
      }
    GRAPHQL
  end
  let(:parsed_response) { make_graphql_request(query: mutation, variables:) }
  let(:user_graphql_token) { parsed_response.dig('data', 'signInUser', 'data', 'token') }
  let(:variables) do
    {
      input: {
        email: current_gql_user.email,
        password: current_gql_user.password
      }
    }
  end

  context 'Signing user in providing its email and password' do
    it 'should return some value in the token field' do
      expect(user_graphql_token).not_to eq(nil)
    end

    it 'should return a String as token' do
      expect(user_graphql_token).to be_a String
    end

    it 'should return a token of some length' do
      expect(user_graphql_token.length).to be > 0
    end

    it 'should return a JWT token' do
      expect { JWT.decode(user_graphql_token, ENV['JWT_SECRET_KEY'], true, { algorithm: 'HS256' }) }.not_to raise_error
    end
  end

  context 'Signing user in providing wrong password' do
    before { variables[:input][:password] = 'WRONG_PASSWORD' }

    it_behaves_like :single_validation_error do
      let(:result) { parsed_response }
    end

    # should return wrong credentials error
    it_behaves_like :expect_single_error_message, 'signInUser', I18n.t('messages.errors.users.wrong_credentials') do
      let(:result) { parsed_response }
    end

    it 'should not return a token' do
      expect(user_graphql_token).to be nil
    end
  end
end
# rubocop:enable Metrics/BlockLength
