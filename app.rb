require 'sinatra/base'
require './lib/bookmarks.rb'

# Class comment
class BookmarkManager < Sinatra::Base
  enable :sessions


  get '/' do
    'Hello World'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  run! if app_file == $PROGRAM_NAME
end
