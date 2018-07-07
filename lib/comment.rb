require 'pg'

class Comment

  attr_reader :id, :comment, :bookmark_id

  def initialize(id, comment, bookmark_id)
    @id = id
    @comment = comment
    @bookmark_id = bookmark_id
  end

  def self.all
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec('SELECT * FROM comments')
    result.map do |comment|
      Comment.new(comment['id'], comment['comment'], comment['bookmark_id'])
    end
  end

  def self.add(bookmark_id, comment)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec("INSERT INTO comments (comment, bookmark_id) VALUES ('#{comment}', '#{bookmark_id}') RETURNING id, comment, bookmark_id;")
    Comment.new(result.first['id'], result.first['comment'], result.first['bookmark_id'])
  end

  def self.retrieve(bookmark_id)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec("SELECT * FROM comments WHERE bookmark_id='#{bookmark_id}';")
    result.map do |comment|
      Comment.new(comment['id'], comment['comment'], comment['bookmark_id'])
    end
  end


  def ==(other)
    @id == other.id
  end

end
