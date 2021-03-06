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

  describe 'POST #create' do
    let(:user_params) do
      {
        user: {
          name: 'Fulano',
          email: 'xpto@teste.com',
          zipcode: zipcode
        }
      }
    end

    subject { post '/v1/users', params: user_params }

    context 'address already persisted' do
      let(:address) { create :address, zipcode: '09080321' }
      let(:zipcode) { address.zipcode }

      it { is_expected.to eq 201 }

      it { expect { subject }.to change(User, :count).by(1) }
    end

    context 'address invalid', :vcr do
      let(:zipcode) { '09426329' }

      it { is_expected.to eq 422 }
      it { expect { subject }.to change(User, :count).by(0) }
    end
  end

  describe 'PUT #update' do
    let(:user) { create :user }

    subject { put "/v1/users/#{user.id}", params: { user: user_params } }

    context 'with valid params' do
      let(:user_params) { { name: 'Beltrano' } }

      it 'updates requested record' do
        subject
        expect(user.reload.name).
          to eq(user_params[:name])

        expect(response.body).
          to eq(
            { user: UserSerializer.new(user.reload).attributes }.to_json
          )
      end
    end

    context 'changing address', :vcr do
      let(:user_params) { { name: 'Beltrano', zipcode: '01311200' } }

      it 'updates requested record' do
        subject
        expect(user.reload.name).
          to eq(user_params[:name])

        expect(response.body).
          to eq(
            { user: UserSerializer.new(user.reload).attributes }.to_json
          )
      end
    end
  end
end
