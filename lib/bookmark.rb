require 'pg'

class Bookmark

  def self.all

    connection = connect

    result = connection.exec("SELECT * FROM bookmarks;")
    result.map { |bookmark| bookmark['url'] }
  end

  def self.add(url)

    connection = connect
    connection.prepare('add', 'insert into bookmarks (url) VALUES ($1);')
    connection.exec_prepared('add', [ url ] )
  end

  def self.delete(url)
    puts "Deleting... " + url

    prepared_string = "delete from bookmarks where url='#{url}';"

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
