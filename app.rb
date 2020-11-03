require 'sinatra/base'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base
  get '/' do
    'Bookmark Manager'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/button-redirect' do
    puts params[:action]
    if params[:action] == "🗑"
      redirect_string = '/delete?title=' + params[:title]
      redirect redirect_string, 307
    elsif params[:action] == "V"
      p "Viewing page..."
    end
  end

  get '/delete' do
    Bookmark.delete(params[:title])
    redirect '/bookmarks'
  end


  post '/add-bookmark' do
    Bookmark.add(params[:bookmark], params[:title])
    redirect '/bookmarks'
  end


  run! if app_file == $0
end
