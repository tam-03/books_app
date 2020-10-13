class AddProviderUidToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end
  add_index :users, [:provider, :uid], unique: true
end