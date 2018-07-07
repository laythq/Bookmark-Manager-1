require 'pg'
require 'uri'
require_relative 'comment'

class Bookmark
  attr_reader :id, :url, :title, :comment

  def initialize(id, url, title)
    @id = id
    @url = url
    @title = title
  end

  def self.all
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec('SELECT * FROM bookmarks')
    result.map do |bookmark|
      Bookmark.new(bookmark['id'], bookmark['url'], bookmark['title'])
    end
  end

  def self.add(title, url)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    result = connection.exec("INSERT INTO bookmarks (title, url) VALUES ('#{title}', '#{url}') RETURNING id, url, title;")
    Bookmark.new(result.first['id'], result.first['url'], result.first['title'])
  end

  def self.valid_url(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

  def self.delete(id)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    connection.exec("DELETE FROM bookmarks WHERE id='#{id}';")
  end

  def self.update(id, title, url)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    bookmark = connection.exec("UPDATE bookmarks SET title='#{title}', url='#{url}' WHERE id='#{id}' RETURNING id, url, title;")
    Bookmark.new(bookmark.first['id'], bookmark.first['url'], bookmark.first['title'])
  end

  def self.add_comment(id, comment)
    Comment.add(id, comment)
  end

  def self.retrieve(bookmark_id)
    comments = Comment.retrieve(bookmark_id)
    comments.map { |comment| comment.comment }
  end

  def ==(bookmark)
    @id == bookmark.id
  end
end
