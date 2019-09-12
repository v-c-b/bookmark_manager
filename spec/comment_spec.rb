require './lib/bookmarks.rb'
require 'database_helper.rb'
require 'pg'
require 'uri'
require 'comment'

describe Comment do
  describe '#add' do
    it 'adds a comment to a bookmark' do
      trunc_test_database
      PG.connect dbname: 'bookmark_manager_test'
      bookmark = Bookmark.add(title: 'BBC', url: 'www.bbc.co.uk')
      test_comment = Comment.add(bookmark.id, "This is a test comment")
      expect(Comment.all[0].text).to eq "This is a test comment"
    end
  end

  describe '#find' do
    it 'finds the comment that has been added' do
      trunc_test_database
      PG.connect dbname: 'bookmark_manager_test'
      bookmark = Bookmark.add(title: 'BBC', url: 'www.bbc.co.uk')
      test_comment = Comment.add(bookmark.id, "This is a test comment")
      expect(Comment.find(bookmark.id)[0].text).to eq "This is a test comment"
    end
    end

end
