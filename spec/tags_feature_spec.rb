feature 'Tags' do
  scenario 'user can add a tag' do
    trunc_test_database
    populate_test_database
    visit '/bookmarks'
    first('.bookmark').click_button 'Add tag'
    fill_in :tag, with: 'xyz*1453'
    click_button 'Submit'
    expect(page).to have_content('xyz*1453')
  end
end
