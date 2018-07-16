feature 'authentification' do
  it 'a user can sign in' do
    User.create(email: 'laythq@gmail.com', password: 'password')
    visit 'sessions/new'
    fill_in('email', with: 'laythq@gmail.com')
    fill_in('password', with: 'password')
    click_button('Sign in')
    expect(page).to have_content 'Welcome, laythq@gmail.com'
  end

  it 'a user sees an error if they get their email wrong' do
    User.create(email: 'laythq@gmail.com', password: 'password')
    visit 'sessions/new'
    fill_in('email', with: 'wrong@gmail.com')
    fill_in('password', with: 'wrong')
    click_button('Sign in')
    expect(page).not_to have_content 'Welcome, laythq@gmail.com'
  end

  it 'a user can sign out' do
    User.create(email: 'laythq@gmail.com', password: 'password')
    visit 'sessions/new'
    fill_in('email', with: 'laythq@gmail.com')
    fill_in('password', with: 'password')
    click_button('Sign in')
    click_button('Sign out')
    expect(page).not_to have_content 'Welcome, laythq@gmail.com'
  end
end
