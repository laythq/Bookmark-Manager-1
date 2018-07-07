require 'tag-junction'
require 'bookmark'
require 'tag'

describe TagJunction do
  describe '#new_tag(bookmark)' do
    it 'assigns a new tag to a bookmark' do
      tag = TagJunction.new_tag(bookmark)
      expect(Bookmark.return_tags(bookmark)).to eq [tag]
    end
  end

  describe '#new_bookmark(tag)' do
    it 'assigns a new bookmark to a tag' do
      bookmark = TagJunction.new_bookmark(tag)
      expect(Bookmark.return_bookmarks(tag)).to eq [bookmark]
    end
  end
end
