feature 'Add bookmarks' do
  scenario 'add a bookmark' do
    visit '/'
    fill_in('url', with: 'http://makersacademy.com')
    click_button('Add bookmark')
    expect(page).to have_content 'http://makersacademy.com'
  end
end
