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

  test "dummy_email" do
    auth_user =  User.create!(name: "auth_user", email: "auth_user@example.com", password: "password", uid: 1, provider: "github")
    assert_equal User.dummy_email(auth_user), "1-github@example.com"
  end

  test "from_omniauth" do
    OmniAuth.config.test_mode = true

    auth = OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: "github",
      uid: "123456",
      info: {
        nickname: "charlie",
        email: "charlie@example.com"
      }
    })

    auth_user_create = User.from_omniauth(auth)
    assert_equal auth_user_create.provider, "github"
    assert_equal auth_user_create.uid, "123456"
    assert_equal auth_user_create.name, "charlie"
    assert_equal auth_user_create.email, "123456-github@example.com"
    assert auth_user_create.password
    
    auth_user_find = User.from_omniauth(auth)
    assert_equal auth_user_create.provider, auth_user_find.provider
    assert_equal auth_user_create.uid, auth_user_find.uid
    assert_equal auth_user_create.name, auth_user_find.name
    assert_equal auth_user_create.email, auth_user_find.email
  end

end
