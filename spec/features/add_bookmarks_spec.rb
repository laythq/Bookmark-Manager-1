feature 'Add bookmarks' do
  scenario 'add a bookmark' do
    visit '/'
    fill_in('title', with: 'Makers Academy')
    fill_in('url', with: 'http://makersacademy.com')
    click_button('Add bookmark')
    expect(page).to have_content 'Makers Academy'
  end
  scenario 'invalid entry' do
    visit '/'
    fill_in('title', with: 'Not a bookmark')
    fill_in('url', with: 'not a bookmark')
    click_button('Add bookmark')
    expect(page).to have_content 'Cannot add: not a valid URL'
  end
end
