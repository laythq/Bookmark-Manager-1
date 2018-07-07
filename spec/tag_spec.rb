require 'tag'
require 'bookmark'

describe Tag do
  describe '#add_tag(id, tag)' do
    it 'user can add a new tag' do
      bookmark1 = Bookmark.add('Makers Academy', 'http://makersacademy.com')
      bookmark2 = Bookmark.add('Google', 'http://google.com')
      id = bookmark1.id
      tag = Tag.add_tag(id, 'sports')
      expect(Tag.all_tags).to eq [tag]
    end
  end

  describe '#all_tags' do
    it 'user can see all tags' do
      bookmark1 = Bookmark.add('Makers Academy', 'http://makersacademy.com')
      bookmark2 = Bookmark.add('Google', 'http://google.com')
      id = bookmark1.id
      tag = 'sports'
      id2 = bookmark2.id
      tag2 = 'film'
      tag1 = Tag.add_tag(id, tag)
      tag2 = Tag.add_tag(id2, tag2)
      tags = [tag1, tag2]
      expect(Tag.all_tags).to eq tags
    end
  end
end
