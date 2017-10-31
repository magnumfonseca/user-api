class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  belongs_to :address
end
