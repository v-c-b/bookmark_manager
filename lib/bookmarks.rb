require 'pg'
require 'uri'
require_relative './databaseconnection'
# manages bookmarks
class Bookmark
  # manages bookmarks
  attr_reader :id, :title, :url

  def self.all
    rs = DatabaseConnection.query('SELECT * FROM bookmarks')
    rs.map { |b| Bookmark.new(id: b['id'], title: b['title'], url: b['url']) }
  end

  def self.add(title:, url:)
    r = DatabaseConnection.query("INSERT INTO bookmarks (title, url)
      VALUES ('#{title}', '#{url}') RETURNING id, title, url;")
    Bookmark.new(id: r[0]['id'], title: r[0]['title'], url: r[0]['url'])
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.update(id, title, url)
    DatabaseConnection.query("UPDATE bookmarks SET url='#{url}', title='#{title}' WHERE id=#{id};")
  end

  def self.find(id)
    rs = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id=#{id}")
    test = rs.map { |b| Bookmark.new(id: b['id'], title: b['title'], url: b['url']) }
    test.first
  end

  def self.validate(url)
    if (url =~ /\A#{URI::regexp(['http', 'https'])}\z/) == nil then
      false
    else true
    end
  end

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end
end
