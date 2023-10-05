RSpec.shared_examples 'single success response' do |query_name|
  it 'has a data Hash' do
    expect(result['data']).to be_a Hash
  end

  it 'returns an object with the id specified in the query' do
    expect(result['data'][query_name]['id'].to_i).to eq(object.id)
  end
end

RSpec.shared_examples 'single mutation success response' do |mutation_name, message|
  it 'has a data Hash' do
    expect(result['data']).to be_a Hash
  end

  it 'returns the created object id' do
    expect(result['data'][mutation_name]['data']['id'].to_i).to be_instance_of(Integer)
  end

  it 'returns the notice' do
    expect(result['data'][mutation_name]['message']).to eq(message)
  end

  it 'returns the success boolean' do
    expect(result['data'][mutation_name]['success']).to be(true)
  end
end

RSpec.shared_examples 'already exists response' do |mutation_name, response_message|
  it 'has success key in false' do
    expect(result['data'][mutation_name]['success']).to eq(false)
  end

  it 'returns the expected response message' do
    expect(result['data'][mutation_name]['message']).to eq(response_message)
  end
end
