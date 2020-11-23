# frozen_string_literal: true

require 'application_system_test_case'

class ReportCommentsTest < ApplicationSystemTestCase
  setup do
    @alice_report_comment = comments(:alice_report_comment)
    @report = reports(:report)
    @alice = users(:alice)
    @bob = users(:bob)
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'creating a report comment' do
    visit report_url(@report)
    click_link "コメント一覧"
    assert_no_text "ギアセカンド！"
    click_link "コメントする"
    visit new_report_comment_path(@report)
    fill_in "内容", with: "ギアセカンド！"
    click_button "登録する"
    Comment.create!(body: "ギアセカンド！", commentable: @report, user_id: 3)
    assert_text "ギアセカンド！"
  end

  test 'showing report comment' do
    visit report_url(@report)
    click_link "コメント一覧"
    assert_no_text "ギアセカンド！"
    click_link "コメントする"
    fill_in "内容", with: "ギアセカンド！"
    click_button "登録する"
    assert_text "ギアセカンド！"
  end

  test 'updating a report comment' do
    visit report_comments_url(@report)
    click_link '編集'
    assert_no_text 'コメントが正常に更新されました。'
    assert_no_text '多重影分身の術!'
    fill_in '内容', with: "多重影分身の術!"
    click_on '更新する'
    assert_text 'コメントが正常に更新されました。'
    assert_text '多重影分身の術!'
  end

  test 'destroying a report comment' do
    assert_no_text 'コメントが正常に破棄されました。'
    visit report_comments_url(@report)
    page.accept_confirm do
      click_on '削除'
    end
    assert_text 'コメントが正常に破棄されました。'
  end
end
