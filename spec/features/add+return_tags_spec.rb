feature 'Add Tag ' do
  scenario 'add a tag to a bookmark' do
    visit '/'
    fill_in('title', with: 'Makers Academy')
    fill_in('url', with: 'http://makersacademy.com')
    click_button('Add bookmark')
    click_button('Add Tag', match: :first)
    fill_in('tag', with: 'Coding')
    click_button('Add Tag')
    expect(page).to have_content 'Coding'
  end
end

feature 'Return Tags' do
  scenario 'see all tags for a specific bookmark' do
    visit '/'
    fill_in('title', with: 'Makers Academy')
    fill_in('url', with: 'http://makersacademy.com')
    click_button('Add bookmark')
    click_button('Add Tag', match: :first)
    fill_in('tag', with: 'Coding')
    click_button('Add Tag')
    click_button('Add Tag', match: :first)
    fill_in('tag', with: 'Work')
    click_button('Add Tag')
    expect(page).to have_content 'Coding', 'Work'
  end
end
