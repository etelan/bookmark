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
    if params[:action] == "D"
      redirect '/delete?url=' + params[:url]
    elsif params[:action] == "V"
      p "Viewing page..."
    end
  end

  get '/delete' do
    Bookmark.delete(params[:url])
    redirect '/bookmarks'
  end


  post '/add-bookmark' do
    Bookmark.add(params[:bookmark])
    redirect '/bookmarks'
  end


  run! if app_file == $0
end
