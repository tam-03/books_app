class ChangeColumnsAddNotnullOnUserRelationships < ActiveRecord::Migration[6.0]
  def change
    change_column_null :user_relationships, :following_id, false
    change_column_null :user_relationships, :follower_id, false
  end
end
