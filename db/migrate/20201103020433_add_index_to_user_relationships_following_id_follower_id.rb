class AddIndexToUserRelationshipsFollowingIdFollowerId < ActiveRecord::Migration[6.0]
  def change
    add_index :user_relationships, [:following_id, :follower_id]
  end
end
