require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe GraphqlController, '#UserQuery', type: :controller do
  include GraphqlHelper
  include_context(:user)
  include_context(:admin)

  let(:query) do
    <<-GRAPHQL
      query($userId: ID) {
        user(id: $userId) {
          birthday
          email
          id
          lastName
          name
          fullname
          phone
          token
          verifiedAccount
        }
      }
    GRAPHQL
  end

  let(:parsed_response) { make_graphql_request(query:, variables:, user_token:) }
  let(:user_token) { current_gql_user.graphql_token }
  let(:variables) { { userId: nil } }

  context 'when JWTACCESSTOKEN header is missing or incorrect' do
    describe 'token is missing' do
      let(:user_token) { nil }

      it_behaves_like 'single error', I18n.t('not_authorized_error') do
        let(:result) { parsed_response }
      end
    end

    describe 'token is incorrect' do
      let(:user_token) { 'invalid_token' }

      subject { parsed_response['error']['message'] }
      it { is_expected.to eq(I18n.t('messages.errors.jwt.invalid_token')) }
    end
  end

  context 'when an user try request another user information' do
    let!(:new_user) { create(:user) }
    let(:variables) { { userId: new_user.id } }

    describe 'when user is not admin returns error' do
      it_behaves_like 'single error', I18n.t('not_authorized_error') do
        let(:result) { parsed_response }
      end
    end

    describe 'when user is admin returns success response' do
      let(:user_token) { current_gql_admin.graphql_token }

      it_behaves_like 'single success response', 'user' do
        let(:object) { new_user }
        let(:result) { parsed_response }
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
