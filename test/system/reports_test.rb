# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:report)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'creating a Report' do
    visit reports_url
    click_on '新規追加'

    fill_in '日報', with: @report.title
    fill_in '内容', with: @report.body
    click_on '登録する'

    assert_text '日報が正常に作成されました。'
  end

  test 'updating a Report' do
    visit reports_url
    click_on '編集'

    fill_in '日報', with: @report.title
    fill_in '内容', with: @report.body
    click_on '更新する'

    assert_text '日報が正常に更新されました。'
  end

  test 'destroying a Report' do
    visit reports_url
    page.accept_confirm do
      click_on '削除'
    end

    assert_text '日報が正常に破棄されました。'
  end
end
