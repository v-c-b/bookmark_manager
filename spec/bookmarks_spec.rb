# unit tests for bookmarks
require './lib/bookmarks.rb'
require 'database_helper.rb'
require 'pg'

describe 'adding a bookmark' do
  it 'updates the database' do
    trunc_test_database
    Bookmark.add(title: 'BBC', url: 'www.bbc.co.uk')
    con = PG.connect dbname: 'bookmark_manager_test'
    result = con.exec "SELECT * FROM bookmarks where url = 'www.bbc.co.uk'"
    expect(result.values[0][1]).to eq('www.bbc.co.uk')
    expect(result.values[0][2]).to eq('BBC')
  end
  it 'creates a bookmark' do
    trunc_test_database
    bookmark = Bookmark.add(title: 'BBC', url: 'www.bbc.co.uk')
    expect(bookmark.title).to eq('BBC')
    expect(bookmark.url).to eq('www.bbc.co.uk')
  end
end

describe 'deletes a bookmark' do
  it 'updates the database' do
    trunc_test_database
    p = Bookmark.add(title: 'BBC', url: 'www.bbc.co.uk')
    Bookmark.delete(id: p.id)
    con = PG.connect dbname: 'bookmark_manager_test'
    result = con.exec "SELECT * FROM bookmarks where url = 'www.bbc.co.uk'"
    expect(result.values).to eq([])
  end
end

describe '#find' do
  it 'returns the correct bookmark' do
    drop_test_database
    populate_test_database
    expect(Bookmark.find(1).title).to eq('Google')
    expect(Bookmark.find(1).url).to eq('http://www.google.com')
  end
end

describe '#update' do
  it 'changes the correct bookmark entry' do
    drop_test_database
    populate_test_database
    Bookmark.update(1, 'Gooogle', 'www.gooogle.com')
    expect(Bookmark.find(1).title).to eq('Gooogle')
    expect(Bookmark.find(1).url).to eq('www.gooogle.com')
  end
end
