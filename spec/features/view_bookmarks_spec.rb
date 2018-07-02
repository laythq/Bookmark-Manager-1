feature 'view bookmarks' do
  scenario 'view bookmarks' do
    visit('/bookmarks')
    expect(page).to have_content 'www.google.co.uk'
    expect(page).to have_content 'www.theguardian.com'
    expect(page).to have_content 'www.twitter.com'
    expect(page).to have_content 'www.bbc.co.uk'
  end
end
