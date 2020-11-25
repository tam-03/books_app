# frozen_string_literal: true

require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:one_piece)
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test "visiting the index and edit and delete of other_user_book are not listed" do
    visit books_url
    assert_selector "h1", text: "本の一覧"
    assert_text 'タイトル'
    assert_text 'メモ'
    assert_text '著者'
    assert_text '写真'
    click_link 'ログアウト'
    fill_in 'Eメール', with: 'bob@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    assert_no_text '編集'
    assert_no_text '削除'
  end

  test "showing a Book" do
    visit book_url(@book)
    assert_text @book.title
    assert_text @book.memo
  end

  test "creating a Book" do
    visit books_url
    click_on "新規追加"

    fill_in "タイトル", with: "naruto"
    fill_in "メモ", with: "火影になる！"
    click_on "登録する"

    assert_text "書籍が正常に作成されました。"
    assert_text "naruto"
    assert_text "火影になる！"

  end

  test "updating a Book" do
    visit books_url
    click_on "編集"

    fill_in "タイトル", with: "naruto"
    fill_in "メモ", with: "火影になる！"
    click_on "更新"

    assert_text "書籍が正常に更新されました。"
    assert_text "naruto"
    assert_text "火影になる！"
  end

  test "destroying a Book" do
    visit books_url
    page.accept_confirm do
      click_on "削除"
    end

    assert_text "書籍が正常に破棄されました。"
  end
end
