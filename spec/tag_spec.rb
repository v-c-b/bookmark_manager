require 'tag'
require 'database_helper.rb'
require 'pg'

describe Tag do
  describe '#create' do
    it 'lets user add a tag to a bookmark' do
      trunc_test_database
      PG.connect dbname: 'bookmark_manager_test'
      test_tag = Tag.create('test tag')
      expect(Tag.all[0].content).to eq('test tag')
    end
  end
  describe '#associate' do
    it 'associates a tag (id) with a bookmark id' do
      trunc_test_database
      populate_test_database
      # PG.connect dbname: 'bookmark_manager_test'
      test_tag = Tag.create('test tag')
      result = DatabaseConnection.query("SELECT * FROM bookmarks where url = 'http://www.google.com'")
      bookmark_id = result.values[0][0]
      Tag.associate(bookmark_id, test_tag.id)
      test_result = DatabaseConnection.query("SELECT * FROM bookmarks_tags where bookmark_id = '#{bookmark_id}'")
      expect(test_result.values[0][0]).to eq(test_tag.id)
      expect(test_result.values[0][1]).to eq(bookmark_id)
    end
  end
end
