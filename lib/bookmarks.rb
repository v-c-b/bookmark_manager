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

  def self.update(id, title, url)
    open_db_connection
    @con.exec("UPDATE bookmarks SET url='#{url}', title='#{title}' WHERE id=#{id};")
  end

  def self.find(id)
    open_db_connection
    rs = @con.exec "SELECT * FROM bookmarks WHERE id=#{id}"
    test = rs.map { |b| Bookmark.new(id: b['id'], title: b['title'], url: b['url']) }
    test.first
  end

  def self.open_db_connection
    if ENV['ENVIRONMENT'] == 'test'
      @con = PG.connect dbname: 'bookmark_manager_test'
    else
      @con = PG.connect dbname: 'bookmark_manager'
    end
  end

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end
end
