# Require PostgreSQL
require 'pg'

def setup_test_database
  # Say what we are doing
  p "Setting up a test database..."

  # Establish Connection
  connection = PG.connect(dbname: 'bookmark_manager_test')

  # Make empty
  connection.exec("TRUNCATE bookmarks;")
end
