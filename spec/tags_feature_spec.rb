feature 'Tags' do
  scenario 'user can add a tag' do
    trunc_test_database
    populate_test_database
    visit '/'
    click_button 'Add tag'
    fill_in :tag, with: 'xyz*1453'
    click_button 'Submit'
    visit '/'
    click_button 'Add tag'
    expect(page).to have_content('xyz*1453')
  end
end
