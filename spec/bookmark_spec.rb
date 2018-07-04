require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      connection.exec("INSERT INTO bookmarks (url) VALUES ('http://google.com');")


      bookmarks = Bookmark.all
      expect(bookmarks).to include('http://google.com')
    end
  end
end
