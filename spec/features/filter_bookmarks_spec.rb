feature 'Filter Bookmarks' do
  scenario 'filter bookmarks by tag' do
    visit '/'
    fill_in('title', with: 'Makers Academy')
    fill_in('url', with: 'http://makersacademy.com')
    click_button('Add bookmark')
    click_button('Add Tag', match: :first)
    fill_in('tag', with: 'Coding')
    click_button('Add Tag')
    click_button('Filter Bookmarks')
    fill_in('tag', with: 'Coding')
    click_button('Filter')
    expect(page).to have_content 'Makers Academy'
  end
end
