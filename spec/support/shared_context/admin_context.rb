RSpec.shared_context(:admin, shared_context: :metadata) do
  let!(:current_gql_admin) { create(:user, admin: true) }
  let(:admin_ability) { Ability.new(current_gql_user) }
  let(:admin_context) do
    {
      current_user:      current_gql_admin,
      current_ability:   admin_ability
    }
  end
end
