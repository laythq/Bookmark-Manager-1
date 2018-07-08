require 'tag'
require 'bookmark'

describe Tag do
  describe '#add_tag(id, tag)' do
    it 'user can add a new tag' do
      tag = Tag.add_tag('sports')
      expect(Tag.all_tags).to eq [tag]
    end
  end

  describe '#all_tags' do
    it 'user can see all tags' do
      tag = 'sports'
      tag2 = 'film'
      tag1 = Tag.add_tag(tag)
      tag2 = Tag.add_tag(tag2)
      tags = [tag1, tag2]
      expect(Tag.all_tags).to eq tags
    end
  end

  describe '#wrap_tag(tag)' do
    it 'wraps an existing tag' do
      tag = Tag.add_tag('sports')
      expect(Tag.wrap_tag('sports')).to eq tag
    end
  end

  describe '#tag_exists?' do
    it 'checks if a tag exists or not' do
      Tag.add_tag('sports')
      expect(Tag.tag_exists?('sports')).to be true
    end

    it 'returns false if tag does not exist' do
      expect(Tag.tag_exists?('games')).to be false
    end

  end
end
