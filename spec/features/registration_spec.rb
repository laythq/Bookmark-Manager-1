feature 'registration' do
  scenario 'a user can sign up' do
    visit '/users/new'
    fill_in('email', with: 'laythq@gmail.com')
    fill_in('password', with: 'password')
    click_button('Sign up')
    expect(page).to have_content 'Welcome, laythq@gmail.com'
  end
end
