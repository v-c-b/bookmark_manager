feature 'Index page test' do
  scenario 'Display Hello World' do
    visit '/'
    expect(page).to have_content 'Hello World'
  end
end

feature 'Bookmark viewing' do
  scenario 'show all bookmarks' do
    visit '/bookmarks'
    expect(page).to have_content 'http://www.google.com'
    expect(page).to have_content 'http://www.bing.com'
    expect(page).to have_content 'http://www.destroyallsoftware.com'

  end
end
