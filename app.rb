require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  get '/bookmarks' do
    erb :index
    @bookmarks = Bookmark.all
  end

  run! if app_file == $PROGRAM_NAME
end
