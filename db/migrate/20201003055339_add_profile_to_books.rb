class AddProfileToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :profile, :text
  end
end
