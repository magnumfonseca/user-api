require 'rails_helper'

RSpec.describe ViaCepService do
  subject! { described_class.attributes_for(zipcode) }

  context 'when is a valid zipcode', :vcr do
    let(:zipcode) { '09080320' }

    let(:body) do
      {
        zipcode: '09080320',
        street: 'Rua Vitória Régia',
        district: 'Campestre',
        city: 'Santo André',
        state: 'SP'
      }
    end

    it { is_expected.to eq body }
  end

  context 'when is a invalid zipcode', :vcr do
    let(:zipcode) { '00080320' }

    let(:body) do
      { 'erro' => true }
    end

    it { is_expected.to eq body }
  end
end
