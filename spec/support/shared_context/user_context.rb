RSpec.shared_context(:user, shared_context: :metadata) do
  let!(:current_gql_user) { create(:user) }
  let(:user_ability) { Ability.new(current_gql_user) }
  let(:user_context) do
    {
      current_user:      current_gql_user,
      current_ability:   user_ability
    }
  end
end
