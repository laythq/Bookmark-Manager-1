require 'pg'
require_relative 'bookmark'
require_relative 'tag'

class TagJunction

  attr_reader :id, :bookmark_id, :tag_id

  def initialize(id, bookmark_id, tag_id)
    @id = id
    @bookmark_id = bookmark_id
    @tag_id = tag_id
  end

  def self.add_tag(tag, bookmark)
    # MUST TAKE TWO INSTANCES OF tag AND bookmark
    result = DatabaseConnection.connection.exec("INSERT INTO tag_junction (bookmark_id, tag_id) VALUES ('#{bookmark.id}', '#{tag.id}') RETURNING id, bookmark_id, tag_id;")
    result.map do |tag|
      TagJunction.new(tag['id'], tag['bookmark_id'], tag['tag_id'])
    end
  end

  def self.add_bookmark(bookmark, tag)
    result = DatabaseConnection.connection.exec("INSERT INTO tag_junction (bookmark_id, tag_id) VALUES ('#{bookmark.id}', '#{tag.id}') RETURNING id, bookmark_id, tag_id;")

    result.map do |bookmark|
      TagJunction.new(bookmark['id'], bookmark['bookmark_id'], bookmark['tag_id'])
    end

    # necessary to wrap object?
    # Tag.new(result.first['id'], result.first['tag'], result.first['bookmark_id'])
  end

  def self.return_tags(bookmark)

    result = DatabaseConnection.connection.exec("SELECT * from tag_junction WHERE bookmark_id=#{bookmark.id};")

    # 1. Fetch rows from tag_junction (id->bookmark_id->tag_id)
    tag_junction = result.map do |tag|
      TagJunction.new(tag['id'], tag['bookmark_id'], tag['tag_id'])
    end

    # 2. Return PG object for each row of tag_junction, wrap as Tag objects
    tag_junction.map do |tag|
      tag = DatabaseConnection.connection.exec("SELECT * from tags WHERE id=#{tag.tag_id};")
      Tag.new(tag.first['id'], tag.first['tag'])
    end

    # 3. Put tags into an array (optional)
    # tags.map {|x| x.tag}

  end

  def self.return_bookmarks(tag)
    result = DatabaseConnection.connection.exec("SELECT * from tag_junction WHERE tag_id=#{tag.id};")

    tag_junction = result.map do |bookmark|
      TagJunction.new(bookmark['id'], bookmark['bookmark_id'], bookmark['tag_id'])
    end

    tag_junction.map do |tag_j|
      tag = DatabaseConnection.connection.exec("SELECT * from bookmarks WHERE id=#{tag_j.bookmark_id};")
      Bookmark.new(tag.first['id'], tag.first['url'], tag.first['title'])
    end

  end

  def ==(other)
    @id == other.id
  end

end
