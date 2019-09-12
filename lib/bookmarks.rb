require 'pg'
# manages bookmarks
class Bookmark
  # manages bookmarks
  attr_reader :id, :title, :url

  def self.all
    open_db_connection
    rs = @con.exec 'SELECT * FROM bookmarks'
    rs.map { |b| Bookmark.new(id: b['id'], title: b['title'], url: b['url']) }
  end

  def self.add(title:, url:)
    open_db_connection
    r = @con.exec "INSERT INTO bookmarks (title, url)
    VALUES ('#{title}', '#{url}') RETURNING id, title, url;"
    Bookmark.new(id: r[0]['id'], title: r[0]['title'], url: r[0]['url'])
  end

  def self.delete(id:)
    open_db_connection
    @con.exec("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.open_db_connection
    if ENV['ENVIRONMENT'] == 'test'
      @con = PG.connect dbname: 'bookmark_manager_test', user: 'student'
    else
      @con = PG.connect dbname: 'bookmark_manager', user: 'student'
    end
  end

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end
end
