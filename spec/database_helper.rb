# sets up and cleans the test database for testing purposes
def trunc_test_database
  con = PG.connect dbname: 'bookmark_manager_test', user: 'student'
  con.exec 'TRUNCATE bookmarks'
end

def populate_test_database
  con = PG.connect dbname: 'bookmark_manager_test', user: 'student'
  con.exec "INSERT INTO bookmarks (title, url)
    VALUES('Google', 'http://www.google.com')"
  con.exec "INSERT INTO bookmarks (title, url)
    VALUES('Bing', 'http://www.bing.com')"
  con.exec "INSERT INTO bookmarks (title, url)
    VALUES('Destroyallsoftware', 'http://www.destroyallsoftware.com')"
end
