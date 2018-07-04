require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  get '/' do
    @bookmarks = Bookmark.all
    erb :index
  end

  post '/bookmarks' do
    Bookmark.add(params[:url])
    redirect '/'
  end

  run! if app_file == $PROGRAM_NAME
end
