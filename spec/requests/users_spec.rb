require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  before(:each) do
    host! 'api.example.com'
  end

  let!(:user) { create :user }

  describe 'GET #index' do
    let(:expected_response) do
      [JSON.parse(UserSerializer.new(user).attributes.to_json)]
    end

    it 'returns user and address' do
      get '/v1/users'

      body = JSON.parse(response.body)
      expect(body['users']).not_to be_empty
      expect(body['users']).to eq(expected_response)
    end
  end

  describe 'GET #show' do
    let(:expected_response) do
      JSON.parse(UserSerializer.new(user).attributes.to_json)
    end

    it 'response user and address' do
      get "/v1/users/#{user.id}"

      body = JSON.parse(response.body)
      expect(body['user']).not_to be_empty
      expect(body['user']).to eq(expected_response)
    end
  end

  describe 'DELETE #destroy' do
    subject { delete "/v1/users/#{user.id}" }

    it { is_expected.to eq(204) }
    it 'removes requested record' do
      expect { subject }.to change(User, :count).by(-1)
    end
  end
end
