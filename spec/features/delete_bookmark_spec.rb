feature 'delete bookmarks' do
  scenario 'user deletes a bookmark' do
    visit('/')
    fill_in('title', with: 'Facebook')
    fill_in('url', with: 'http://facebook.com')
    click_button('Add bookmark')
    click_button('Delete', match: :first)
    expect(page).not_to have_content 'Facebook'
  end
end
