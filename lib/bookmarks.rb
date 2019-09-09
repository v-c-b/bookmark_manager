# comment
require 'pg'
class Bookmark
  attr_reader :name

  def self.all
    a = []
    con = PG.connect :dbname => 'bookmark', :user => 'student'
    rs = con.exec "SELECT * FROM bookmarks"
    rs.map { |bookmark| bookmark['url'] }
  end
end
