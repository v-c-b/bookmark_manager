# comment
require 'pg'
class Bookmark
  attr_reader :name

  def self.all
    if ENV['ENVIRONMENT'] == 'test' then
      con = PG.connect :dbname => 'bookmark_manager_test', :user => 'student'
    else
      con = PG.connect :dbname => 'bookmark_manager', :user => 'student'
    end
    rs = con.exec "SELECT * FROM bookmarks"
    rs.map { |bookmark| bookmark['url'] }
  end
end
