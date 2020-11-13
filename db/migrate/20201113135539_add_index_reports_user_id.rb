class AddIndexReportsUserId < ActiveRecord::Migration[6.0]
  def change
    add_index :reports, :user_id
  end
end
