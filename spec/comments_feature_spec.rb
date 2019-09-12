require 'sinatra/flash'
feature 'Add comments' do
  before :each do
    trunc_test_database
  end
  scenario 'User can add a comment to a bookmark' do
    populate_test_database
    visit'/bookmarks'
    first('.bookmark').click_button 'Comment'
    fill_in :comment, with: "Hey I'm testing"
    click_button 'Submit'
    expect(page).to have_content "Hey I'm testing"
  end
end
