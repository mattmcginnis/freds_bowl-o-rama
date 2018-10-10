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
    # We've provided a couple of tests to show the input/output formats and to
    # give a structure in which you can put your own tests. Use the
    # `request_body` and `parsed_response` helpers, defined above.
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

    # The scoring endpoint should also be able to show who is the current
    # winner and the score so far for an incomplete game.
    context 'happy path - two bowlers mid-game' do
      let(:request_body) do
        {
          'Frank Zappa': [
            { 'score': 'x' },  # 10 + 8 + 3
            { 'score': 8 },    # 8
            { 'score': 3 },    # 3
          ],
          'Don Van Vliet': [
            { 'score': 7 },    # 7
            { 'score': '4/' }, # 10 + 6
            { 'score': 6 },    # 6
          ],
        }.to_json
      end

      it 'responds with 200 status' do
        expect(response.status).to be 200
      end

      it 'chooses the correct winner' do
        expect(parsed_response['winner']).to eq 'Frank Zappa'
      end

      it 'scores the game correctly' do
        expect(parsed_response['scores']['Frank Zappa']).to eq 32
        expect(parsed_response['scores']['Don Van Vliet']).to eq 29
      end
    end
  end
end
