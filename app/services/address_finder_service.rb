class AddressFinderService
  attr_accessor :zipcode

  def self.find(zipcode)
    new(zipcode).find
  end

  def initialize(zipcode)
    @zipcode = zipcode
  end

  def find
    return cached_address.id unless cached_address.blank?

    return nil if via_cep_attributes['erro']

    new_address.id
  end

  private

  def cached_address
    @cached_address ||= Address.find_by(zipcode: zipcode)
  end

  def new_address
    Address.create(via_cep_attributes)
  end

  def via_cep_attributes
    @via_cep_attributes ||= ViaCepService.attributes_for(zipcode)
  end
end
