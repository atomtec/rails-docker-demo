require 'rails_helper'

RSpec.describe "Api::V1::Authentications", type: :request do
    let(:user){FactoryBot.create(:user, username: 'Abc123',password: 'password')}
    it 'authenticates the client ' do
      post '/api/v1/authenticate', params: {username: user.username, password: 'password'}
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to eq({'token'=>'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiQWJjMTIzIn0.O_ZRyTwYwM1fViw0h0jG6xy8Eh_d9OjrihclsFeiDe4'})
    end 
    it 'returns error when username is missing' do
      post '/api/v1/authenticate', params: {password: 'password'}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to eq({'errors'=>'param is missing or the value is empty: username'})
    end
    it 'returns error when password is missing' do
      post '/api/v1/authenticate', params: {username: 'abc1'}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to eq({'errors'=>'param is missing or the value is empty: password'})
    end
    it 'returns error when password is incorrect' do
      post '/api/v1/authenticate', params: {username: user.username, password: 'wrong_password'}
      expect(response).to have_http_status(:unauthorized)
    end
end