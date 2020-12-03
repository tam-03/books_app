# frozen_string_literal: true

require 'application_system_test_case'

class UserRelationshipsTest < ApplicationSystemTestCase
  setup do
    @alice = users(:alice)
    @bob = users(:bob)
    @dave = users(:dave)
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'are all users listed?' do
    click_link 'ユーザー一覧'
    assert_selector 'h1', text: 'ユーザー一覧'
    assert_text @bob.name
    assert_text 'フォローする'
    assert_text @dave.name
    assert_text 'フォローする'
  end

  test 'follow and unfollow' do
    click_link 'ユーザー一覧'
    assert_text 'フォローする'
    click_link 'フォローする', match: :first
    assert_text 'フォロー済み'
    click_link 'フォロー済み', match: :first
    assert_text 'フォローする'
  end

  test 'follow list and follow list on the current user screen' do
    click_link 'ユーザー一覧'
    click_link 'bob'
    assert_text 'フォローする'
    click_link 'フォローする'
    assert_text 'フォロー済み'

    click_link 'alice'
    click_link 'フォローユーザー一覧'
    assert_selector 'h1', text: 'フォロー一覧'
    assert_text 'bob'
    assert_text 'フォロー済み'

    click_link 'ログアウト'
    fill_in 'Eメール', with: 'dave@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    click_link 'ユーザー一覧'
    click_link 'フォローする', match: :first
    click_link 'ログアウト'

    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'

    click_link 'alice'
    click_link 'フォロワーユーザー一覧'
    assert_selector 'h1', text: 'フォロワー一覧'
    assert_text 'dave'
    assert_text 'フォローする'
  end

  test 'follow or unfollow the screen of other_user' do
    click_link 'ユーザー一覧'
    click_link 'bob'
    assert_text 'フォローする'
  end

end
