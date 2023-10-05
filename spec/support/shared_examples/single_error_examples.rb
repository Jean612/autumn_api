RSpec.shared_examples 'single error' do |error_message|
  it 'has one single error' do
    expect(result['errors'].count).to eq(1)
  end

  it 'returns the expected error message' do
    expect(result['errors'].first['message']).to eq(error_message)
  end
end
