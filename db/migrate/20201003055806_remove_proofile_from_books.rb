class RemoveProofileFromBooks < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :profile, :text
  end
end
