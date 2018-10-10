# These are some RSpec tests to get you started and give a clear idea how we
# will test this on our end. Please feel free to add any tests you want here.
require 'rails_helper'

RSpec.describe '/scores requests', type: :request do
  let(:request_headers) { {
    'Accepts': 'application/json',
    'Content-Type': 'application/json',
  } }
  let(:request_body) do
    {}.to_json
  end
  let(:parsed_response) { JSON.parse(response.body) }

  before do
    post '/scores', params: request_body, headers: request_headers
  end

  describe 'POST /scores' do
    context 'happy path - a perfect game' do
      let(:request_body) do
        {
          'Nikola Tesla': [
            { 'score': 10 },
            { 'score': 10 },
            { 'score': 10 },
            { 'score': 10 },
            { 'score': 10 },
            { 'score': 10 },
            { 'score': 10 },
            { 'score': 10 },
            { 'score': 10 },
            { 'score': 10 },
          ],
        }.to_json
      end

      it 'responds with 200 status' do
        expect(response.status).to be 200
      end

      it 'chooses the correct winner' do
        expect(parsed_response['winner']).to eq 'Nikola Tesla'
      end

      it 'scores the game correctly' do
        expect(parsed_response['scores']['Nikola Tesla']).to eq 300
      end
    end

    context 'a complete game' do
      let(:request_body) do
        {
          'Frank Zappa': [
            { 'score': '-' },
            { 'score': 1 },
            { 'score': 2 },
            { 'score': 3 },
            { 'score': 'F' },
            { 'score': '3/' },
            { 'score': 8 },
            { 'score': 'x' },
            { 'score': 7 },
            { 'score': 3 },
          ],
          'Don Van Vliet': [
            { 'score': '/' },
            { 'score': 3 },
            { 'score': 9 },
            { 'score': 'X' },
            { 'score': 'f' },
            { 'score': 1 },
            { 'score': 'X' },
            { 'score': '-' },
            { 'score': 8 },
            { 'score': 7 },
          ],
        }.to_json
      end

      it 'responds with 200 status' do
        expect(response.status).to be 200
      end

      it 'chooses the correct winner' do
        expect(parsed_response['winner']).to eq 'Don Van Vliet'
      end

      it 'scores the game correctly' do
        expect(parsed_response['scores']['Frank Zappa']).to eq 51
        expect(parsed_response['scores']['Don Van Vliet']).to eq 58
      end
    end
  end
end
