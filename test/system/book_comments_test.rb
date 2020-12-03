# frozen_string_literal: true

require 'application_system_test_case'

class BookCommentsTest < ApplicationSystemTestCase
  setup do
    @alice_book_comment = comments(:alice_book_comment)
    @book = books(:one_piece)
    @alice = users(:alice)
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'creating a book comment' do
    visit book_url(@book)
    click_link "コメント一覧"
    assert_no_text "ギアサード！"
    click_link "コメントする"
    fill_in "内容", with: "ギアサード！"
    click_button "登録する"
    assert_text "ギアサード！"
  end

  test 'showing book comment' do
    visit book_url(@book)
    click_link "コメント一覧"
    click_link "表示"
    assert_text "アリスのコメント"
  end

  test 'updating a book comment' do
    visit book_comments_url(@book)
    click_link '編集'
    assert_no_text 'コメントが正常に更新されました。'
    assert_no_text '螺旋丸!'
    fill_in '内容', with: "螺旋丸!"
    click_on '更新する'
    assert_text 'コメントが正常に更新されました。'
    assert_text '螺旋丸!'
  end

  test 'destroying a book comment' do
    assert_no_text 'コメントが正常に破棄されました。'
    visit book_comments_url(@book)
    page.accept_confirm do
      click_on '削除'
    end
    assert_text 'コメントが正常に破棄されました。'
  end
end
