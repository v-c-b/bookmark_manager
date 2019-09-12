# main sinatra app with routes
require 'sinatra/base'
require './lib/bookmarks.rb'

# Class comment
class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override

  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  post '/action' do
    redirect '/bookmarks/add' if params[:submit] == 'add_bookmark'
    redirect '/bookmarks' if params[:submit] == 'view_bookmark'
    redirect '/bookmarks/delete' if params[:submit] == 'delete_bookmark'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/delete' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/delete'
  end

  get '/bookmarks/remove' do
    Bookmark.delete(params[:title])
    redirect '/bookmarks'
  end

  get '/bookmarks/add' do
    erb :'bookmarks/add'
  end

  get '/bookmarks/store' do
    Bookmark.add(title: params[:title], url: params[:url])
    redirect '/bookmarks'
  end
  run! if app_file == $PROGRAM_NAME
end
