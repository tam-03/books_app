require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:one_piece)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test "visiting the index" do
    visit books_url
    assert_selector "h1", text: "本の一覧"
  end

  test "creating a Book" do
    visit books_url
    click_on "新規追加"

    fill_in "タイトル", with: @book.title
    fill_in "メモ", with: @book.memo
    click_on "登録する"

    assert_text "書籍が正常に作成されました。"
  end

  test "updating a Book" do
    visit books_url
    click_on "編集"

    fill_in "メモ", with: @book.memo
    fill_in "タイトル", with: @book.title
    click_on "更新"

    assert_text "書籍が正常に更新されました。"
  end

  test "destroying a Book" do
    visit books_url
    page.accept_confirm do
      click_on "削除"
    end

    assert_text "書籍が正常に破棄されました。"
  end
end
