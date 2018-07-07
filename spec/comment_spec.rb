require 'comment'
require 'bookmark'

describe Comment do
  describe '#add' do
    it 'adds a new comment' do
      bookmark = Bookmark.add('Makers Academy', 'http://makersacademy.com')
      comment = 'The best'
      new_comment = Comment.add(bookmark.id, comment)
      expect(Comment.all). to eq [new_comment]
    end
  end

  describe '#retrieve' do
    it 'retrieves previous comments' do
      bookmark = Bookmark.add('Makers Academy', 'http://makersacademy.com')
      comment = 'The best'
      new_comment = Comment.add(bookmark.id, comment)
      expect(Comment.retrieve(bookmark.id)).to eq [new_comment]
    end
  end

end
