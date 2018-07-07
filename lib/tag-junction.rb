require 'pg'


class Tag

  attr_reader :id, :bookmark_id, :tag

  def initialize(id, bookmark_id, tag)
    @id = id
    @bookmark_id = bookmark_id
    @tag = tag
  end

  def self.all_tags
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec('SELECT * FROM tags')
    result.map do |tag|
      Tag.new(tag['id'], tag['tag'], tag['bookmark_id'])
    end
  end

  def self.add_tag(bookmark_id, tag)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    result = connection.exec("INSERT INTO tags (tag, bookmark_id) VALUES ('#{tag}', '#{bookmark_id}') RETURNING id, tag, bookmark_id;")
    Tag.new(result.first['id'], result.first['tag'], result.first['bookmark_id'])
  end

  def ==(other)
    @id == other.id
  end
end
