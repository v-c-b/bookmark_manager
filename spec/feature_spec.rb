# feature tests for the bookmark manager
feature 'Bookmark viewing' do
  before :each do
    trunc_test_database
  end
  scenario 'show all bookmarks' do
    populate_test_database
    visit '/bookmarks'
    expect(page).to have_link('Google', href: 'http://www.google.com')
    expect(page).to have_link('Bing', href: 'http://www.bing.com')
    expect(page).to have_link('Destroyallsoftware', href: 'http://www.destroyallsoftware.com')
  end
end

feature 'Add Bookmark' do
  before :each do
    trunc_test_database
  end
  scenario 'input new bookmark' do
    populate_test_database
    visit '/'
    click_button 'add_bookmark'
    fill_in :title, with: 'BBC'
    fill_in :url, with: 'http://www.bbc.co.uk'
    click_button 'submit'
    expect(page).to have_link('BBC', href: 'http://www.bbc.co.uk')
  end
end

feature 'Delete Bookmark' do
  before :each do
    trunc_test_database
  end
  scenario 'A user can delete a bookmark' do
    Bookmark.add(url: 'www.makersacademy.com', title: 'Makers')
    visit('/bookmarks')
    expect(page).to have_link('Makers', href: 'www.makersacademy.com')
    first('.bookmark').click_button 'Delete'
    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Makers', href: 'www.makersacademy.com')
  end
end

feature 'Update Bookmark' do
  before :each do
    trunc_test_database
  end
  scenario 'A user can update a bookmark' do
    populate_test_database
    visit('/bookmarks')
    expect(page).to have_link('Google', href: 'http://www.google.com')
    first('.bookmark').click_button 'Update'
    fill_in :url, with: 'https://www.google.com'
    fill_in :name, with: 'Google_updated'
    click_button('Submit')
    expect(page).to have_link('Google_updated', href: 'https://www.google.com')
  end
end
