require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      bookmark1 = Bookmark.add('Makers Academy', 'http://makersacademy.com')
      bookmark2 = Bookmark.add('Google', 'http://google.com')
      bookmarks = [bookmark1, bookmark2]
      expect(Bookmark.all).to eq(bookmarks)
    end
  end

  describe '.add' do
    it 'adds a new bookmark' do
      bookmark = [Bookmark.add('Makers Academy', 'http://makersacademy.com')]
      expect(Bookmark.all).to eq(bookmark)
    end
  end

  describe '.delete' do
    it 'removes a bookmark from database' do
      bookmark = Bookmark.add('Makers Academy', 'http://makersacademy.com')
      Bookmark.delete(bookmark.id)
      expect(Bookmark.all).not_to include(bookmark)
    end
  end

  describe '.update' do
    it 'changes the bookmark attributes' do
      bookmark = Bookmark.add('Makers Academy', 'http://makersacademy.com')
      new_bookmark = Bookmark.update(bookmark.id, 'General Assembly', 'http://generalassembly.com')
      expect(Bookmark.all).to eq([new_bookmark])
    end
  end
end
