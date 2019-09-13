# main sinatra app with routes
require 'sinatra/base'
require 'sinatra/flash'
require './lib/bookmarks.rb'
require './lib/comment.rb'
require './lib/tag.rb'
require './lib/database_connection_setup.rb'


# Class comment
class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

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
    redirect '/tags/create' if params[:submit] == 'add_tag'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  patch '/bookmarks/update/:id' do
    @bookmark = Bookmark.find(params[:id])
    erb :'/bookmarks/update'
  end

  post '/bookmarks/comment/:id' do
    @bookmark = Bookmark.find(params[:id])
    erb :'/bookmarks/add_comment'
  end

  post '/bookmarks/store_comment/:id' do
    Comment.add(params[:id], params[:comment])
    redirect '/bookmarks'
  end

  post '/bookmarks/change/:id' do
    if Bookmark.validate(params[:url]) == false
      @bookmark = Bookmark.find(params[:id])
      flash[:notice] = "Incorrect URL - try again"
      redirect '/bookmarks'
    else
      Bookmark.update(params[:id], params[:title], params[:url])
      redirect '/bookmarks'
    end
  end

  get '/bookmarks/add' do
    erb :'bookmarks/add'
  end

  get '/bookmarks/store' do
      if Bookmark.validate(params[:url]) == false
        flash[:notice] = "Incorrect URL - try again"
        redirect '/bookmarks/add'
      else
        Bookmark.add(title: params[:title], url: params[:url])
        redirect '/bookmarks'
    end
  end

  # post '/bookmarks/tag/:id' do
  #   @bookmark_id = params[:id]
  #   erb :'tags/add'
  # end
  #
  post '/tags/store/' do
    Tag.create(params[:tag])
    redirect '/bookmarks'
  end

  get '/tags/create' do
    erb :'tags/add'
  end

  run! if app_file == $PROGRAM_NAME
end
