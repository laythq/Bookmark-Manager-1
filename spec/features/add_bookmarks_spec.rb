feature 'Add bookmarks' do
  scenario 'add a bookmark' do
    visit '/'
    fill_in('url', with: 'http://makersacademy.com')
    click_button('Add bookmark')
    expect(page).to have_content 'http://makersacademy.com'
  end
  scenario 'invalid entry' do
    visit '/'
    fill_in('url', with: 'not a bookmark')
    click_button('Add bookmark')
    expect(page).to have_content 'Cannot add: not a valid URL'
  end
end
