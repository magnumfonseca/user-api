require 'rails_helper'

RSpec.describe AddressFinderService do
  subject! { described_class.find(zipcode) }

  context 'when is a valid zipcode' do
    context 'and is a persisted address' do
      let(:address) { create :address }
      let(:zipcode) { address.zipcode }

      it { is_expected.to eq address.id }
    end

    context 'address is a new address', :vcr do
      let(:zipcode) { '09426320' }

      it { is_expected.to eq Address.last.id }
    end
  end

  context 'when is a invalid zipcode', :vcr do
    let(:zipcode) { '09426329' }

    it { is_expected.to be_nil }
  end
end
