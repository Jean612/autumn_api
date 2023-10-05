module GraphqlHelper
  # Mocks the generation of Ability object in replacement of the old context[:current_ability] mock
  def force_ability(action:, class_or_instance:, return_value: false)
    mocked_ability = instance_double(Ability)
    allow(Ability).to receive(:new).and_return(mocked_ability)
    allow(mocked_ability).to receive(:can?).with(action, class_or_instance).and_return(return_value)
  end

  def make_graphql_request(query:, headers: {}, variables: {}, parse_response: true, token: ENV['AUTUMN_TOKEN'], user_token: nil)
    default_headers = { 'Content-Type': 'application/json', 'HTTP_AUTUMN_TOKEN': token, 'HTTP_JWTACCESSTOKEN': user_token }
    request.headers.merge!(default_headers.merge(headers).with_indifferent_access)

    post 'execute', params: { query:, variables: }

    parse_response ? JSON.parse(response.body) : response
  end
end
