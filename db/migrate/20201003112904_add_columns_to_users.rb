class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :postal_code, :integer
    add_column :users, :street_address, :string
  end
end
