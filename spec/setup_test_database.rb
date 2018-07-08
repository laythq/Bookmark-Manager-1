require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'bookmark_manager_test')
  connection.exec('TRUNCATE TABLE bookmarks CASCADE')
  connection.exec('TRUNCATE TABLE tags CASCADE')
  connection.exec('TRUNCATE TABLE tag_junction CASCADE')

  # connection.exec('TRUNCATE TABLE comments')

end
