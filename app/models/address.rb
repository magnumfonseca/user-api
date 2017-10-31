class Address < ApplicationRecord
  validates :zipcode, presence: true, uniqueness: true
end
