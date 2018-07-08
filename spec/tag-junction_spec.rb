require 'tag-junction'
require 'bookmark'
require 'tag'

describe TagJunction do
  describe '#add_tag(tag, bookmark)' do
    it 'assigns a new tag to a bookmark' do
      tag = Tag.add_tag('sports')
      bookmark = Bookmark.add('Makers Academy', 'http://makersacademy.com')
      TagJunction.add_tag(tag, bookmark)
      expect(TagJunction.return_tags(bookmark)).to eq [tag]
    end
  end

  describe '#add_bookmark(bookmark, tag)' do
    it 'assigns a new bookmark to a tag' do
      tag = Tag.add_tag('sports')
      bookmark = Bookmark.add('Makers Academy', 'http://makersacademy.com')
      TagJunction.add_bookmark(bookmark, tag)
      expect(TagJunction.return_bookmarks(tag)).to eq [bookmark]
    end
  end

  describe '#return_tags(bookmarks)' do
    it 'returns all the tags of a specific bookmark' do
      tag1 = Tag.add_tag('sports')
      tag2 = Tag.add_tag('film')
      bookmark = Bookmark.add('Makers Academy', 'http://makersacademy.com')
      TagJunction.add_tag(tag1, bookmark)
      TagJunction.add_tag(tag2, bookmark)
      expect(TagJunction.return_tags(bookmark)).to eq [tag1, tag2]
    end
  end

  describe '#return_bookmark(tag)' do
    it 'returns all the tags of a specific bookmark' do
      tag = Tag.add_tag('sports')
      bookmark1 = Bookmark.add('Makers Academy', 'http://makersacademy.com')
      bookmark2 = Bookmark.add('Google', 'http://google.com')
      TagJunction.add_bookmark(bookmark1, tag)
      TagJunction.add_bookmark(bookmark2, tag)
      expect(TagJunction.return_bookmarks(tag)).to eq [bookmark1, bookmark2]
    end
  end
end
