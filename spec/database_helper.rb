# sets up and cleans the test database for testing purposes
def trunc_test_database
  con = PG.connect dbname: 'bookmark_manager_test'
  con.exec 'TRUNCATE bookmarks CASCADE'
end

def populate_test_database
  con = PG.connect dbname: 'bookmark_manager_test'
  con.exec "INSERT INTO bookmarks (title, url)
    VALUES('Google', 'http://www.google.com')"
  con.exec "INSERT INTO bookmarks (title, url)
    VALUES('Bing', 'http://www.bing.com')"
  con.exec "INSERT INTO bookmarks (title, url)
    VALUES('Destroyallsoftware', 'http://www.destroyallsoftware.com')"
end

def drop_test_database
  con = PG.connect dbname: 'bookmark_manager_test'
  con.exec 'DROP TABLE bookmarks CASCADE'
  con.exec 'CREATE TABLE bookmarks(id SERIAL PRIMARY KEY,
    url VARCHAR(60), title VARCHAR(60));'
end
