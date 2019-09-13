require 'tag'
describe Tag do
  describe '#create' do
    it 'lets user add a tag to a bookmark' do
      trunc_test_database
      PG.connect dbname: 'bookmark_manager_test'
      bookmark = Bookmark.add(title: 'BBC', url: 'www.bbc.co.uk')
      test_tag = Tag.create(bookmark.id, 'test tag')
      expect(Tag.all[0].content).to eq()'test tag')
    end
  end
end
