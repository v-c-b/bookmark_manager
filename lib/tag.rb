require 'pg'
require_relative './databaseconnection'

class Tag
attr_reader :id, :content

  def initialize(id:, content:)
    @id = id
    @content = content
  end

  def self.create(content)
    r = DatabaseConnection.query("INSERT INTO tags (content)
      VALUES ('#{content}') RETURNING id, content;")
    Tag.new(id: r[0]['id'], content: r[0]['content'])
  end

  def self.all
    r = DatabaseConnection.query('SELECT * FROM tags')
    r.map { |b| Tag.new(id: b['id'], content: b['content'])}
  end

end
