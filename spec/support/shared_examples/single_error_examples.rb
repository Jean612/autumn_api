RSpec.shared_examples 'single error' do |error_message|
  it 'has one single error' do
    expect(result['errors'].count).to eq(1)
  end

  it 'returns the expected error message' do
    expect(result['errors'].first['message']).to eq(error_message)
  end
end

RSpec.shared_examples :single_validation_error do
  it 'Should have one single validation error' do
    expect(result['errors'][0]['extensions']['error_type']).to eq('validation')
  end
end

RSpec.shared_examples :expect_single_error_message do |mutation_name, error_message|
  it 'Should have a key with the mutation name under the data key' do
    expect(result['data'].key?(mutation_name)).to be(true)
  end

  it 'Should have its data > mutation name key have a nil value' do
    expect(result['data'][mutation_name]).to be_nil
  end

  it 'Should have one single error' do
    expect(result['errors'].count).to eq(1)
  end

  it 'Should return the expected error message' do
    expect(result['errors'].first['message']).to eq(error_message)
  end
end
