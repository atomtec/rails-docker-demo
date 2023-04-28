require 'rails_helper'

RSpec.describe AuthenticationTokenService do
    describe '.call' do
        let(:token) { described_class.call("Abc123") }  
        it 'returns a JWT token' do
            decoded_token = JWT.decode(token, described_class::HMAC_SECRET, true, { algorithm: described_class::ALGORITHM_TYPE })
            expect(decoded_token).to eq(
                [
                    {"user_id"=>"Abc123"}, # payload
                    {"alg"=>"HS256"} # header
                ]
            )
        end
    end
end