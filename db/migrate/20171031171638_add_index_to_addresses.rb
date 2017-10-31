class AddIndexToAddresses < ActiveRecord::Migration[5.1]
  def change
    add_index :addresses, :zipcode, unique: true
  end
end
