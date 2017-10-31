class AddressSerializer < ActiveModel::Serializer
  attributes :zipcode, :street, :district, :city, :state
end
