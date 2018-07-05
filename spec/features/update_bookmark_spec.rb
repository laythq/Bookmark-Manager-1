feature 'update bookmarks' do
  scenario 'user updates a bookmark' do
    visit('/')
    fill_in('title', with: 'Facebook')
    fill_in('url', with: 'http://facebook.com')
    click_button('Add bookmark')
    click_button('Update', match: :first)
    fill_in('title', with: 'MySpace')
    fill_in('url', with: 'http://myspace.com')
    click_button('Update')
    expect(page).not_to have_content 'Facebook'
    expect(page).to have_content 'MySpace'
  end
end
