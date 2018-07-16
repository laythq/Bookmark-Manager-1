require 'pg'


class Tag

  attr_reader :id, :tag

  def initialize(id, tag)
    @id = id
    @tag = tag
  end

  def self.all_tags

    result = DatabaseConnection.connection.exec('SELECT * FROM tags')
    result.map do |tag|
      Tag.new(tag['id'], tag['tag'])
    end
  end

  def self.add_tag(tag)

    result = DatabaseConnection.connection.exec("INSERT INTO tags (tag) VALUES ('#{tag}') RETURNING id, tag;")
    Tag.new(result.first['id'], result.first['tag'])
  end

  def self.wrap_tag(tag)

    tag = DatabaseConnection.connection.exec("SELECT * FROM tags WHERE tag='#{tag}';")
    Tag.new(tag.first['id'], tag.first['tag'])
  end

  def self.tag_exists?(tag)

    result = DatabaseConnection.connection.exec("SELECT EXISTS (SELECT * FROM tags WHERE tag='#{tag}');")
    boolean = result.map {|x| x}

    if boolean.first['exists'] == 't'
      true
    else
      false
    end

  end

  def ==(other)
    @id == other.id
  end
end
