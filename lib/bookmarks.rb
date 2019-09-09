# comment
class Bookmark
  attr_reader :name

  def self.all
    [
      'http://www.google.com',
      'http://www.bing.com',
      'http://www.yahoo.com'
    ]
  end
end
