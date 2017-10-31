class AddAddressesToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :addresses, foreign_key: true
  end
end
