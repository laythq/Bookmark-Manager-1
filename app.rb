require 'sinatra/base'
require './lib/bookmark'
require './lib/comment'

class BookmarkManager < Sinatra::Base
  set :method_override, true

  get '/' do
    @url_invalid = params[:url_invalid]
    @bookmarks = Bookmark.all
    erb :index
  end

  get '/bookmarks/update' do
    @bookmark = params[:id]
    erb :update
  end

  get '/bookmarks/comment' do
    @bookmark = params[:id]
    erb :comment
  end

  post '/bookmarks' do
    if Bookmark.valid_url(params[:url])
      Bookmark.add(params[:title], params[:url])
      redirect '/'
    else
      redirect '/?url_invalid=true'
    end
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(params[:id])
    redirect '/'
  end

  patch '/bookmarks/:id/update' do
    Bookmark.update(params[:id], params[:title], params[:url])
    redirect '/'
  end

  patch '/bookmarks/:id/comment' do
    Bookmark.add_comment(params[:id], params[:comment])
    redirect '/'
  end

  run! if app_file == $PROGRAM_NAME
end
