require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "followed_by?" do
    me = User.create!(id: 1, name: "me", email: "me@example.com", password: "password")
    she = User.create!(id: 2, name: "she", email: "she@example.com", password: "password")

    follow = me.active_relationships.build(follower_id: 2)
    follow.save

    assert_not me.followed_by?(she)
    assert she.followed_by?(me)
  end

  test "set_dummy_email" do
    auth_user =  User.create!(name: "auth_user", email: "auth_user@example.com", password: "password", uid: 1, provider: "github")
    assert_equal User.dummy_email(auth_user), "1-github@example.com"
  end
end
