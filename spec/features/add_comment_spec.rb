feature 'Add comment:' do
  scenario 'add a comment to a bookmark' do
    visit '/'
    fill_in('title', with: 'Makers Academy')
    fill_in('url', with: 'http://makersacademy.com')
    click_button('Add bookmark')
    click_button('Add comment')
    fill_in('comment', with: 'The best bootcamp')
    click_button('Submit')
    expect(page).to have_content 'The best bootcamp'
  end
end
