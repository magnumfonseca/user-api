require 'rails_helper'

RSpec.describe Address, type: :model do
  it { should validate_uniqueness_of(:zipcode) }
end
