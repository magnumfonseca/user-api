require 'rails_helper'

RSpec.describe 'routes to the users controller', type: :routing do
  let(:url) { 'http://api.domain.com' }
  let(:bad_url) { 'http://bad_url.domain.com' }

  it 'routes to index' do
    expect(get: "#{url}/v1/users").
      to route_to(controller: 'api/v1/users', action: 'index', subdomain: 'api')
  end

  it 'should not route' do
    expect(get: "#{bad_url}/v1/users").
      not_to route_to(controller: 'api/v1/users', action: 'index', subdomain: 'api')
  end
end
