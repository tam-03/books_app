# frozen_string_literal: true

require 'application_system_test_case'

class UserTest < ApplicationSystemTestCase
  setup do
    @alice = users(:alice)
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'github sign in' do
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: "github",
      uid: "123456",
      info: {
        nickname: "charlie",
        email: "charlie@example.com"
      }
    })
    
    click_link 'ログアウト'
    click_link 'GitHubでログイン'
    assert_text 'charlie'
  end

  test 'account registration' do
    click_link 'ログアウト'
    click_link 'アカウント登録'
    fill_in 'アカウント名', with: 'Carol'
    fill_in 'Eメール', with: 'carol@example.com'
    fill_in '郵便番号', with: '222222'
    fill_in '住所', with: '埼玉県和光市丸山台000'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    click_button 'アカウント登録'

    assert_text 'アカウント登録が完了しました。'
    assert_text 'Carol'

    click_link 'Carol'
    assert_selector 'h1', text: 'アカウント名'
    assert_text 'Carol'
    assert_selector 'h3', text: 'Eメール'
    assert_text 'carol@example.com'
    assert_selector 'h3', text: 'アバター'
    assert_selector 'h3', text: '郵便番号'
    assert_text '222222'
    assert_selector 'h3', text: '住所'
    assert_text '埼玉県和光市丸山台000'
    assert_selector 'h3', text: 'プロフィール'
    assert_selector 'h3', text: 'フォロー'
    assert_text 'フォローユーザー一覧'
    assert_selector 'h3', text: 'フォロワー'
    assert_text 'フォロワーユーザー一覧'
    assert_selector 'h3', text: 'Carolの投稿一覧'
  end

  test 'user sign out' do
    click_link 'ログアウト'
    assert_text 'サインアップ'
    assert_text 'ログイン'
    assert_text 'アカウント登録もしくはログインしてください。'
    assert_selector 'h2', text: 'ログイン'
    assert_text 'Eメール'
    assert_text 'パスワード'
    check('user_remember_me')
    page.has_checked_field?('user_remember_me')
    uncheck('user_remember_me')
    assert_text 'ログインを記憶する'
    page.has_button?('ログイン')
    assert_text 'アカウント登録'
    assert_text 'パスワードを忘れましたか?'
    assert_text 'GitHubでログイン'
  end

  test 'user edit' do
    visit user_url(@alice)
    click_link 'プロフィール変更'

    fill_in 'アカウント名', with: 'carol'
    fill_in 'Eメール', with: 'carol@example.com'
    fill_in '郵便番号', with: '222222'
    fill_in '住所', with: '埼玉県和光市丸山台000'
    fill_in 'プロフィール', with: 'carolのプロフィールです'
    fill_in 'パスワード', with: 'qwerty'
    fill_in 'パスワード（確認用）', with: 'qwerty'
    click_button '更新'

    assert_text 'アカウント情報を変更しました。'
    click_link 'carol'

    assert_text 'carol'
    assert_text 'carol@example.com'
    assert_text '222222'
    assert_text '埼玉県和光市丸山台000'
    assert_text 'carolのプロフィールです'
  end

  test 'user destroy' do
    click_link 'プロフィール変更'
    click_button 'アカウント削除'
    page.driver.browser.switch_to.alert.accept
    assert_text 'アカウント登録もしくはログインしてください。'
  end
end
