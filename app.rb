require 'sinatra/base'
require 'sinatra/flash'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    @url_invalid = params[:url_invalid]
    @bookmarks = Bookmark.all
    erb :index
  end

  post '/bookmarks' do
    if Bookmark.valid_url(params[:url])
      Bookmark.add(params[:title], params[:url])
      redirect '/'
    else
      redirect '/?url_invalid=true'
    end
  end

  run! if app_file == $PROGRAM_NAME
end
