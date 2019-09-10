feature 'Index page test' do
  scenario 'Display Hello World' do
    visit '/'
    expect(page).to have_content 'Hello World'
  end
end

feature 'Bookmark viewing' do
  before :each do
    trunc_test_database
  end
  scenario 'show all bookmarks' do
    populate_test_database
    visit '/bookmarks'
    expect(page).to have_content 'http://www.google.com'
    expect(page).to have_content 'http://www.bing.com'
    expect(page).to have_content 'http://www.destroyallsoftware.com'
  end
end
