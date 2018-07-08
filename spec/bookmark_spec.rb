require 'bookmark'
require 'tag'
require 'tag-junction'


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

  describe '#retrieve_comment' do
    it 'retrieves comments for that bookmark' do
      bookmark = Bookmark.add('Makers Academy', 'http://makersacademy.com')
      comment = 'comment'
      new_comment = Comment.add(bookmark.id, comment)
      expect(Bookmark.retrieve(bookmark.id)).to eq [new_comment.comment]
    end
  end

    describe '#wrap_bookmark(bookmark_id)' do
      it 'wraps an existing tag' do
        bookmark = Bookmark.add('Facebook', 'http://www.facebook.com')
        expect(Bookmark.wrap_bookmark(bookmark.id)).to eq bookmark
      end
    end


end
