require 'sinatra/base'
require './lib/bookmark'
require './lib/comment'
require './lib/tag-junction'
require './lib/user'

class BookmarkManager < Sinatra::Base
  set :method_override, true
  enable :sessions

  get '/' do
    @user = User.find(session[:id])
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

  get '/bookmarks/tags' do
    @bookmark = params[:id]
    erb :new_tag
  end

  get '/bookmarks/filter-bookmarks' do
    erb :filter_by_bookmarks
  end

  get '/users/new' do
    erb :new_user
  end

  get '/sessions/new' do
    erb :new_session
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

  post '/bookmarks/:id/tags' do
    if Tag.tag_exists?(params[:tag])
      tag = Tag.wrap_tag(params[:tag])
      bookmark = Bookmark.wrap_bookmark(params[:id])
      TagJunction.add_tag(tag, bookmark)
    else
      tag = Tag.add_tag(params[:tag])
      bookmark = Bookmark.wrap_bookmark(params[:id])
      TagJunction.add_tag(tag, bookmark)
    end
    redirect '/'
  end

  post '/bookmarks/filtered' do
    p tag = Tag.wrap_tag(params[:tag])
    p @bookmarks = TagJunction.return_bookmarks(tag)
    erb :show_filtered
  end

  post '/users' do
    user = User.create(email: params[:email], password: params[:password])
    session[:id] = user.id
    redirect '/'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])

    if user
      session[:id] = user.id
      redirect '/'
    else
      redirect '/sessions/new'
    end
  end

  post '/sessions/destroy' do
    session.clear
    redirect '/'
  end

  run! if app_file == $PROGRAM_NAME
end
