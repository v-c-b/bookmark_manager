require 'pg'
require 'uri'
require_relative './databaseconnection'


class Comment
  attr_reader :id, :text, :bookmark_id

  def initialize (id:, text:, bookmark_id:)
    @id = id
    @text = text
    @bookmark_id = bookmark_id
  end

  def self.all
    rs = DatabaseConnection.query('SELECT * FROM comments')
    rs.map { |b| Comment.new(id: b['id'], text: b['text'], bookmark_id: b['bookmark_id']) }
  end

  def self.add(bookmark_id, text)
    r = DatabaseConnection.query("INSERT INTO comments (bookmark_id, text)
      VALUES (#{bookmark_id}, '#{text}') RETURNING id, text, bookmark_id;")
    Comment.new(id: r[0]['id'], text: r[0]['text'], bookmark_id: r[0]['bookmark_id'])
  end

  def self.find(bookmark_id)
    r = DatabaseConnection.query("SELECT * FROM comments WHERE bookmark_id='#{bookmark_id}'")
    r.map { |b| Comment.new(id: b['id'], text: b['text'], bookmark_id: b['bookmark_id']) }
  end
end
