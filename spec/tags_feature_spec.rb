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
  scenario 'user can associate a tag' do
    trunc_test_database
    populate_test_database
    visit '/'
    click_button 'Add tag'
    fill_in :tag, with: 'test_tag'
    click_button 'Submit'
    first('.bookmark').click_button('Add tag')
    choose('test_tag')
    click_button('Submit')
    expect(page).to have_content ('test_tag')
  end
end
