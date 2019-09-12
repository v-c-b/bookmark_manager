require 'pg'
require 'databaseconnection'
require 'database_helper'

describe DatabaseConnection do
  describe '#setup' do
    it ' sets up a connection to a chosen database' do
      expect(DatabaseConnection.setup('bookmark_manager_test')).to be_a PG::Connection
    end
  end

  describe '#query' do
    it 'passes a SQL query to the connection that has been setup' do
      drop_test_database
      populate_test_database
      # DatabaseConnection.setup('bookmark_manager_test')
      result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id=1")
      expect(result.values[0][1]).to eq 'http://www.google.com'
    end
  end
end
