class ViaCepService
  attr_accessor :zipcode

  def self.attributes_for(zipcode)
    new(zipcode).attributes_for
  end

  def initialize(zipcode)
    @zipcode = zipcode
  end

  def attributes_for
    return via_cep_address if via_cep_address['erro']
    parsed_attributes
  end

  private

  def via_cep_address
    @via_cep_address ||= JSON.parse(json_response)
  end

  def json_response
    RestClient::Request.
      execute(method: :get, url: url, accept: :json, timeout: 10).body
  rescue RestClient::ExceptionWithResponse
    { 'erro' => true }
  end

  def url
    "https://viacep.com.br/ws/#{zipcode}/json"
  end

  def parsed_attributes
    {
      zipcode: via_cep_address['cep'].delete('-'),
      street: via_cep_address['logradouro'],
      district: via_cep_address['bairro'],
      city: via_cep_address['localidade'],
      state: via_cep_address['uf']
    }
  end
end
