class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates_presence_of :address_id, message: 'zipcode not found'

  belongs_to :address
end
