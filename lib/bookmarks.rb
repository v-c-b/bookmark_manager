# manages bookmarks
require 'pg'
class Bookmark
  # manages bookmarks
  attr_reader :id, :title, :url

  def self.all
    open_db_connection
    rs = @con.exec "SELECT * FROM bookmarks"
    rs.map { |bookmark| Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url']) }
  end

  def self.add(new_title, new_url)
    open_db_connection
    result = @con.exec "INSERT INTO bookmarks (title, url)
      VALUES ('#{new_title}', '#{new_url}') RETURNING id, title, url;"
      Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.delete(title)
    open_db_connection
    result = @con.exec "DELETE FROM bookmarks
      where title = '#{title}'"
  end

  def self.open_db_connection
    if ENV['ENVIRONMENT'] == 'test'
      @con = PG.connect dbname: 'bookmark_manager_test', user: 'student'
    else
      @con = PG.connect dbname: 'bookmark_manager', user: 'student'
    end
  end

  def initialize (id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end
end
