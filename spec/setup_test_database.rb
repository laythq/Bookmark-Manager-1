require 'pg'
require 'database_connection'

def setup_test_database

  if ENV['RACK_ENV'] == 'test'
    DatabaseConnection.setup('bookmark_manager_test')
  else
    DatabaseConnection.setup('bookmark_manager')
  end


  DatabaseConnection.connection.exec('TRUNCATE TABLE bookmarks CASCADE')
  DatabaseConnection.connection.exec('TRUNCATE TABLE tags CASCADE')
  DatabaseConnection.connection.exec('TRUNCATE TABLE tag_junction CASCADE')
  DatabaseConnection.connection.exec('TRUNCATE TABLE users CASCADE')

  # connection.exec('TRUNCATE TABLE comments')

end
