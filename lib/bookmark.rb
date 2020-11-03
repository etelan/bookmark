require 'pg'

class Bookmark

  attr_reader :id, :title, :url

  def initialize(id, title, url)
    @id  = id
    @title = title
    @url = url
  end

  def self.all

    connection = connect

    result = connection.exec("SELECT * FROM bookmarks;")
    result.map do |bookmark|
      Bookmark.new(bookmark['id'], bookmark['title'], bookmark['url'])
    end
  end

  def self.add(url, title)

    connection = connect
    connection.prepare('add', 'insert into bookmarks (url, title) VALUES ($1, $2);')
    result = connection.exec_prepared('add', [ url , title ] )
  end

  def self.delete(title)
    puts "Deleting... " + title

    prepared_string = "delete from bookmarks where title='#{title}';"

    puts prepared_string

    connection = connect
    connection.exec(prepared_string)
  end

  private
  def self.connect

    # Test Environment
    if ENV['ENVIRONMENT'] == 'test'
      @table = 'bookmark_manager_test'
      p "Connecting..."
      connection = PG.connect(dbname: 'bookmark_manager_test')
    # Development Environment
    else
      @table = 'bookmark_manager'
      connection = PG.connect(dbname: 'bookmark_manager')
    end
  end

end
